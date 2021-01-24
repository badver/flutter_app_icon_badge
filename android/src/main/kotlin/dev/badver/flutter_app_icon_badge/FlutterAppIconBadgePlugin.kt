package dev.badver.flutter_app_icon_badge

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import me.leolin.shortcutbadger.ShortcutBadger
import android.content.Context

/** FlutterAppIconBadgePlugin */
class FlutterAppIconBadgePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_app_icon_badge")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("updateBadge")) {
      ShortcutBadger.applyCount(context, Integer.valueOf(call.argument<String>("count").toString()));
      result.success(null);
    } else if (call.method.equals("removeBadge")) {
      ShortcutBadger.removeCount(context);
      result.success(null);
    } else if (call.method.equals("isAppBadgeSupported")) {
      result.success(ShortcutBadger.isBadgeCounterSupported(context));
    } else {
      result.notImplemented();
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
