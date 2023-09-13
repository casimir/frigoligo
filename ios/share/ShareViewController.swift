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
    logger.log("[DEV] \(message)")
}

#if DEBUG
let credentialsKey = "debug.wallabag.credentials"
#else
let credentialsKey = "wallabag.credentials"
#endif

class ShareViewController: SLComposeServiceViewController {
    let userDefaults = UserDefaults(suiteName: "group.net.casimir-lab.frigoligo")!
    var credentials: Credentials?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let raw = userDefaults.string(forKey: credentialsKey)?.data(using: .utf8)
        if let data = raw {
            do {
                self.credentials = try JSONDecoder().decode(Credentials.self, from: data)
            } catch {
                showError("credentials loading error: \(error)")
            }
        }
        devLog("init with valid credentials: \(self.credentials != nil)")
    }

    override func isContentValid() -> Bool {
        if (credentials == nil) {
            // TODO it would be nice to have deeplink in there to open the log in screen directly
            showError("You need to log in with Frigoligo first.")
        }
        return credentials != nil
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let attachment = item.attachments?.first {
            if attachment.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                attachment.loadItem(forTypeIdentifier: UTType.url.identifier, completionHandler: { (url, error) in
                    if let sharedURL = url as? URL {
                        self.saveURL(url: sharedURL)
                    } else {
                        self.showError("invalid URL: \(String(describing: url))")
                    }
                })
            } else {
                devLog("wrong attachment type for \(attachment)")
            }
        } else {
            devLog("could not find any URL in attachments")
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    func getEndpoint(path: String) -> URL {
        return URL(string: path, relativeTo: credentials!.server)!
    }
    
    func getToken() -> String? {
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
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(payload)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var token: String? = nil
        devLog("requesting a fresh token...")
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                self.showError(error.debugDescription)
                semaphore.signal()
                return
            }
    
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse!.statusCode > 200) {
                self.showError("from server: \(String(data: data!, encoding: .utf8)!)")
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
                    self.showError("credentials loading error: \(error)")
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return token
    }

    func saveURL(url: URL) {
        devLog("received an URL to save: \(url)")
        
        var payload =  [String: String]();
        payload["url"] = url.description
        
        var request = URLRequest(url: getEndpoint(path: "/api/entries"))
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(payload)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(getToken()!)", forHTTPHeaderField: "Authorization")
        
        devLog("sending save request...")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                self.showError(error.debugDescription)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse!.statusCode > 200) {
                self.showError("from server: \(String(data: data!, encoding: .utf8)!)")
            } else {
                devLog("article saved!")
            }
        }.resume()
    }
    
    func showError(_ message: String) {
        devLog("ERROR: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
