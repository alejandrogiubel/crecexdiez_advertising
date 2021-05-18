import Flutter
import UIKit

public class SwiftCrecexdiezAdvertisingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "crecexdiez_advertising", binaryMessenger: registrar.messenger())
    let instance = SwiftCrecexdiezAdvertisingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
