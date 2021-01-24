import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAppIconBadge {
  static const MethodChannel _channel =
  const MethodChannel('flutter_app_icon_badge');

  static void updateBadge(int count) {
    _channel.invokeMethod('updateBadge', {"count": count});
  }

  static void removeBadge() {
    _channel.invokeMethod('removeBadge');
  }

  static Future<bool> isAppBadgeSupported() async {
    bool appBadgeSupported = await _channel.invokeMethod('isAppBadgeSupported');
    return appBadgeSupported;
  }
}
