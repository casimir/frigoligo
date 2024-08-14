//
//  AppBadgePlugin.swift
//  Runner
//
//  Created by Martin Chaine on 14/08/2024.
//

import Flutter
import UIKit

public class AppBadgePlugin : NSObject, FlutterPlugin {
    static let CHANNEL = "net.casimir-lab.frigoligo/appbadge"
    
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(AppBadgePlugin(), channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { granted, error in
        }
        
        switch call.method {
        case "update":
            let arguments = call.arguments as? Dictionary<String, Any>
            let count = arguments?["count"] as! Int
            setBadgeCount(count)
            result(nil)
        case "remove":
            setBadgeCount(0)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func setBadgeCount(_ count: Int) {
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(count)
        } else {
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}
