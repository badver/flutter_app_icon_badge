import Cocoa
import FlutterMacOS

public class FlutterAppIconBadgePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_icon_badge", binaryMessenger: registrar.messenger)
    let instance = FlutterAppIconBadgePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "updateBadge":
          if let args = call.arguments as? Dictionary<String, Any>,
            let count = args["count"] as? Int {
            NSApplication.shared.dockTile.badgeLabel = String(count)
            result(nil)
          } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
          }
        case "removeBadge":
          NSApplication.shared.dockTile.badgeLabel = nil
          result(nil)
        case "isAppBadgeSupported":
          result(true)
        case "isAppFocused":
          result(NSApplication.shared.isActive)
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
