//
//  ShareViewController.swift
//  share
//
//  Created by Martin Chaine on 27/08/2023.
//

import UIKit
import UniformTypeIdentifiers
import Social
import SwiftUI

import OSLog
let logger = Logger()

func devLog(_ message: String) {
    logger.log("[DEV] \(message, privacy: .public)")
}

let frigoligoColor = Color(UIColor(red: 0.31372550129999999, green: 0.61960786580000005, blue: 0.7607843876, alpha: 1.0))
#if DEBUG
let credentialsKey = "debug.wallabag.credentials"
#else
let credentialsKey = "wallabag.credentials"
#endif

class ShareViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.net.casimir-lab.frigoligo")!
    var credentials: Credentials?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devLog("viewDidLoad()")
        let toast = CompletionToast(
            vm: ToastViewModel(), // FIXME init inside?
            action: self.doSave,
            didSucceed: { self.exitExtension() },
            onError: { (errorMessage) -> Void in
                self.exitExtension(withErrorMessage: errorMessage)
            },
            strokeColor: frigoligoColor
        )
        let innerController = UIHostingController(rootView: toast)
        innerController.view.backgroundColor = .clear
        addChild(innerController)
        view.addSubview(innerController.view)
        innerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerController.view.topAnchor.constraint(equalTo: view.topAnchor),
            innerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            innerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            innerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        innerController.didMove(toParent: self)
    }
    
    private func exitExtension(withErrorMessage: String? = nil) {
        if (withErrorMessage != nil) {
            devLog("ERROR: \(withErrorMessage!)")
            let alert = UIAlertController(title: "Error", message: withErrorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
                let error = NSError(domain: "net.casimir-lab.frigoligo", code: 0, userInfo: [NSLocalizedDescriptionKey: withErrorMessage!])
                self.extensionContext?.cancelRequest(withError: error)
            }
            alert.addAction(action)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
    }
    
    private func doSave() async throws {
        let raw = userDefaults.string(forKey: credentialsKey)?.data(using: .utf8)
        if let data = raw {
            do {
                credentials = try JSONDecoder().decode(Credentials.self, from: data)
            } catch {
                throw CompletionError.description("credentials loading error: \(error)")
            }
        }
        
        guard
            let items = extensionContext?.inputItems as? [NSExtensionItem],
            let item = items.first,
            let attachments = item.attachments,
            let attachment = attachments.first(where: { item in
                item.hasItemConformingToTypeIdentifier(UTType.url.identifier)
            })
        else {
            throw CompletionError.description("could not extract the url from the attachments")
        }
        do {
            let url = try await attachment.loadItem(forTypeIdentifier: UTType.url.identifier)
            try await self.sendSaveRequest(url: url as! URL)
        } catch let error as CompletionError {
            throw error
        } catch {
            throw CompletionError.description("could not get URL: \(error)")
        }
    }
    
    private func prepareServerRequest(path: String, payload: [String: String]?) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: credentials!.server)!)
        request.setValue("frigoligo/ios-extension", forHTTPHeaderField: "user-agent")
        if payload != nil {
            request.httpMethod = "POST"
            request.httpBody = try! JSONEncoder().encode(payload)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
    
    private func getToken() async throws -> String {
        let tokenDeadline =  Double(credentials!.token.expiresAt) - Date.now.timeIntervalSince1970
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        devLog("token deadline: \(formatter.string(from: tokenDeadline)!)")
        
        if (tokenDeadline > 0) {
            devLog("using existing token")
            return credentials!.token.accessToken
        }
        
        var payload = [String: String]();
        payload["client_id"] = credentials!.clientId
        payload["client_secret"] = credentials!.clientSecret
        payload["grant_type"] =  "refresh_token"
        payload["refresh_token"] = credentials!.token.refreshToken
        let request = prepareServerRequest(path: "/oauth/v2/token", payload: payload)
        
        devLog("requesting a fresh token...")
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        if (httpResponse!.statusCode > 200) {
            throw CompletionError.description("token refresh: from server: \(String(data: data, encoding: .utf8)!)")
        }
        
        do {
            let payload = try JSONDecoder().decode(OAuthTokenBody.self, from: data)
            let token = payload.access_token
            devLog("got a new token!")
            
            self.credentials!.token = buildTokenData(payload)
            let encoder = JSONEncoder()
            let rawCredentials = String(data: try encoder.encode(self.credentials), encoding: .utf8)
            self.userDefaults.set(rawCredentials, forKey: credentialsKey)
            devLog("updated the OAuth token")
            return token
        } catch let error as CompletionError {
            throw error
        } catch {
            throw CompletionError.description("credentials updating error: \(error)")
        }
    }

    func sendSaveRequest(url: URL) async throws {
        devLog("received an URL to save: \(url)")
        
        var payload =  [String: String]();
        payload["url"] = url.description
        if let tag = userDefaults.string(forKey: "settings.tagSaveLabel") {
            payload["tags"] = tag
        }
        var request = prepareServerRequest(path: "/api/entries", payload: payload)
        let token = try await getToken()
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        devLog("sending save request...")
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        if (httpResponse!.statusCode > 200) {
            throw CompletionError.description("save entry: from server: \(String(data: data, encoding: .utf8)!)")
        }
        devLog("article saved!")
    }
}

@objc(ShareNavigationController)
class ShareNavigationController: UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.setViewControllers([ShareViewController()], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
