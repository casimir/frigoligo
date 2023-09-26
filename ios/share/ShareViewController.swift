//
//  ShareViewController.swift
//  share
//
//  Created by Martin Chaine on 27/08/2023.
//

import UIKit
import UniformTypeIdentifiers
import Social

import OSLog
let logger = Logger()

func devLog(_ message: String) {
    logger.log("[DEV] \(message, privacy: .public)")
}

#if DEBUG
let credentialsKey = "debug.wallabag.credentials"
#else
let credentialsKey = "wallabag.credentials"
#endif

class ShareViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.net.casimir-lab.frigoligo")!
    var credentials: Credentials?
    
    let spinner = UIActivityIndicatorView()
    
    private func loadCredentials() -> Bool {
        let raw = userDefaults.string(forKey: credentialsKey)?.data(using: .utf8)
        if let data = raw {
            do {
                credentials = try JSONDecoder().decode(Credentials.self, from: data)
                return true
            } catch {
                // TODO it would be nice to have deeplink in there to open the log in screen directly
                exitExtension(withErrorMessage: "credentials loading error: \(error)")
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        spinner.startAnimating()
        
        doSave()
    }
    
    private func exitExtension(withErrorMessage: String? = nil) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
        
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
            extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
    
    private func doSave() {
        if !loadCredentials() { return }
        
        guard
            let items = extensionContext?.inputItems as? [NSExtensionItem],
            let item = items.first,
            let attachments = item.attachments,
            let attachment = attachments.first
        else {
            exitExtension(withErrorMessage: "Could not extract attachment")
            return
        }
        
        if attachment.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
            attachment.loadItem(forTypeIdentifier: UTType.url.identifier, completionHandler: { (url, error) in
                if (error != nil) {
                    self.exitExtension(withErrorMessage: "Could not get URL: \(error!)")
                } else {
                    self.saveURLAndExit(url: url as! URL)
                }
            })
        } else {
            exitExtension(withErrorMessage: "Wrong attachment type for \(attachment)")
        }
    }
    
    private func getEndpoint(path: String) -> URL {
        return URL(string: path, relativeTo: credentials!.server)!
    }
    
    private func getToken() -> String? {
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
        
        var request = URLRequest(url: getEndpoint(path: "/oauth/v2/token"))
        request.setValue("frigoligo/ios-extension", forHTTPHeaderField:"user-agent")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(payload)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var token: String? = nil
        devLog("requesting a fresh token...")
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                self.exitExtension(withErrorMessage: error.debugDescription)
                semaphore.signal()
                return
            }
    
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse!.statusCode > 200) {
                self.exitExtension(withErrorMessage: "token refresh: from server: \(String(data: data!, encoding: .utf8)!)")
            } else {
                do {
                    let payload = try JSONDecoder().decode(OAuthTokenBody.self, from: data!)
                    token = payload.access_token
                    devLog("got a new token!")
                    
                    self.credentials!.token = buildTokenData(payload)
                    let encoder = JSONEncoder()
                    let rawCredentials = String(data: try encoder.encode(self.credentials), encoding: .utf8)
                    self.userDefaults.set(rawCredentials, forKey: credentialsKey)
                    devLog("updated the OAuth token")
                } catch {
                    self.exitExtension(withErrorMessage: "credentials loading error: \(error)")
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return token
    }

    func saveURLAndExit(url: URL) {
        devLog("received an URL to save: \(url)")
        
        var payload =  [String: String]();
        payload["url"] = url.description
        if let tag = userDefaults.string(forKey: "settings.tagSaveLabel") {
            payload["tags"] = tag
        }
        
        var request = URLRequest(url: getEndpoint(path: "/api/entries"))
        request.setValue("frigoligo/ios-extension", forHTTPHeaderField:"user-agent")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(payload)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(getToken()!)", forHTTPHeaderField: "Authorization")
        
        devLog("sending save request...")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                self.exitExtension(withErrorMessage: error.debugDescription)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse!.statusCode > 200) {
                self.exitExtension(withErrorMessage: "save entry: from server: \(String(data: data!, encoding: .utf8)!)")
            } else {
                devLog("article saved!")
                self.exitExtension()
            }
        }.resume()
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
