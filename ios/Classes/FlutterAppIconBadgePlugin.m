#import "FlutterAppIconBadgePlugin.h"
#if __has_include(<flutter_app_icon_badge/flutter_app_icon_badge-Swift.h>)
#import <flutter_app_icon_badge/flutter_app_icon_badge-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_app_icon_badge-Swift.h"
#endif

@implementation FlutterAppIconBadgePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAppIconBadgePlugin registerWithRegistrar:registrar];
}
@end
