import Flutter
import UIKit

public class SwiftFlutterAppIconBadgePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_icon_badge", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppIconBadgePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: FlutterResult) {
    switch call.method {
    case "updateBadge":
      if let args = call.arguments as? [String: Any],
         let count = args["count"] as? Int
      {
        requestAuthorization(onSuccess: {
          UIApplication.shared.applicationIconBadgeNumber = count
        })

        result(nil)
      } else {
        result(FlutterError(code: "bad args", message: nil, details: nil))
      }
    case "removeBadge":
      requestAuthorization(onSuccess: {
        UIApplication.shared.applicationIconBadgeNumber = 0
      })
      result(nil)
    case "isAppBadgeSupported":
      result(true)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func requestAuthorization(onSuccess: @escaping () -> Void) {
    if #available(iOS 10, *) {
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.badge]) { granted, _ in
        if granted {
          DispatchQueue.main.async {
            // run in main thread
            onSuccess()
          }
        }
      }
    } else {
      let notificationSettings = UIUserNotificationSettings(types: [.badge], categories: nil)
      UIApplication.shared.registerUserNotificationSettings(notificationSettings)
      DispatchQueue.main.async {
        // run in main thread
        onSuccess()
      }
    }
  }
}
