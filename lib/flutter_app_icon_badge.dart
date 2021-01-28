import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAppIconBadge {
  static const MethodChannel _channel = const MethodChannel('flutter_app_icon_badge');

  /// Change badge on app icon
  static void updateBadge(int count) {
    _channel.invokeMethod('updateBadge', {"count": count});
  }

  /// Remove badge on app icon
  static void removeBadge() {
    _channel.invokeMethod('removeBadge');
  }

  /// Check if app badge is supported
  static Future<bool> isAppBadgeSupported() async {
    bool appBadgeSupported = await _channel.invokeMethod('isAppBadgeSupported');
    return appBadgeSupported;
  }

  /// Check if app window is focused.
  static Future<bool> isAppFocused() async {
    bool isAppFocused = await _channel.invokeMethod('isAppFocused');
    return isAppFocused;
  }
}
