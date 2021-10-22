import Flutter
import UIKit

public class SwiftFlutterAppIconBadgePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_icon_badge", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppIconBadgePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "updateBadge":
          if let args = call.arguments as? Dictionary<String, Any>,
            let count = args["count"] as? Int {
            UNUserNotificationCenter.current().requestAuthorization(options: .badge){ 
              (granted, error) in
                if error == nil {
                  UIApplication.shared.applicationIconBadgeNumber = count
                }
            }
            result(nil)
          } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
          }
        case "removeBadge":
          UIApplication.shared.applicationIconBadgeNumber = 0
          result(nil)
        case "isAppBadgeSupported":
          result(true)
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
