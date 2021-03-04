import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAppIconBadge {
  static const MethodChannel _channel = const MethodChannel('flutter_app_icon_badge');

  /// Change badge on app icon
  static Future<void> updateBadge(int count) async {
    await _channel.invokeMethod('updateBadge', {"count": count});
  }

  /// Remove badge on app icon
  static Future<void> removeBadge() async {
    await _channel.invokeMethod('removeBadge');
  }

  /// Check if app badge is supported
  static Future<bool> isAppBadgeSupported() async {
    bool? appBadgeSupported = await _channel.invokeMethod('isAppBadgeSupported');
    return appBadgeSupported ?? false;
  }

  /// Check if app window is focused.
  static Future<bool> isAppFocused() async {
    bool? isAppFocused = await _channel.invokeMethod('isAppFocused');
    return isAppFocused ?? false;
  }
}
