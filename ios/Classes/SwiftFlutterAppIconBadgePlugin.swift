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
      center.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
          DispatchQueue.main.async {
              // run in main thread
              onSuccess()
          }
      }
    } else {
      let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        DispatchQueue.main.async {
            // run in main thread
            onSuccess()
        }

    }
  }

  // func handle(_ call: FlutterMethodCall?, result: FlutterResult) {
  //     enableNotifications()

  //     if "updateBadge" == call?.method {
  //         let args = call?.arguments
  //         let count = args?["count"] as? NSNumber
  //         UIApplication.shared.applicationIconBadgeNumber = count?.intValue ?? 0
  //         result(nil)
  //     } else if "removeBadge" == call?.method {
  //         UIApplication.shared.applicationIconBadgeNumber = 0
  //         result(nil)
  //     } else if "isAppBadgeSupported" == call?.method {
  //         result(NSNumber(value: true))

  //     } else if "isAppBadgeAllowed" == call?.method{
  //       result(enableNotifications())
  //     } else {
  //         result(FlutterMethodNotImplemented)
  //     }
  // }
}
