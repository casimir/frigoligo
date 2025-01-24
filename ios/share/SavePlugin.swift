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
    case "debugHello":
      result("Hello from iOS!")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  public func debugHello() {
    channel.invokeMethod("debugHello", arguments: nil) { result in
      print("swift: \(result as! String)")
    }
  }
  
  @MainActor
  public func saveArticle(url: URL) async throws -> Int? {
    return try await withCheckedThrowingContinuation { continuation in
      self.channel.invokeMethod("saveArticle", arguments: url.absoluteString) {articleId in
        continuation.resume(returning: articleId as? Int)
      }
    }
  }
}
