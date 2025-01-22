//
//  SavePlugin.swift
//  Runner
//
//  Created by Martin Chaine on 21/01/2025.
//

import Flutter

public class SavePlugin : NSObject, FlutterPlugin {
  static let CHANNEL = "net.casimir-lab.frigoligo/save"
  
  private let channel: FlutterMethodChannel
  
  public static var shared: SavePlugin?
  
  public static func register(with registrar: any FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: registrar.messenger())
    let instance = SavePlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: instance.channel)
    
    shared = instance
  }
  
  private init(channel: FlutterMethodChannel) {
    self.channel = channel
    super.init()
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "hello":
      result("Hello from iOS!")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  public func hello() {
    channel.invokeMethod("hello", arguments: nil) { result in
      print("swift: \(result as! String)")
    }
  }
}
