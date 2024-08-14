//
//  AppBadgePlugin.swift
//  Runner
//
//  Created by Martin Chaine on 14/08/2024.
//

import FlutterMacOS

public class AppBadgePlugin : NSObject, FlutterPlugin {
    static let CHANNEL = "net.casimir-lab.frigoligo/appbadge"
    
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(AppBadgePlugin(), channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "update":
            let arguments = call.arguments as? Dictionary<String, Any>
            let count = arguments?["count"] as! Int
            NSApp.dockTile.badgeLabel = String(count)
            result(nil)
        case "remove":
            NSApp.dockTile.badgeLabel = nil;
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
