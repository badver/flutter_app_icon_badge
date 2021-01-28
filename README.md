# Flutter App Icon Badge plugin

This [Flutter](https://flutter.io) plugin you can use to change the badge of the app

## Supported platforms
* iOS
* Android - some Android devices (the official API does not support the feature, even on Oreo)
* MacOs
* Windows - work in progress (need help)
* Linux - work in progress (need help)

## Getting Started

### iOS

On iOS, the notification permission is required to update the badge.
It is automatically asked when the badge is added or removed.

Please also add the following to your Info.plist:
```xml
<key>UIBackgroundModes</key>
    <array>
        <string>remote-notification</string>
    </array>
```

### Android

On Android, no official API exists to show a badge in the launcher. But some devices (Samsung, HTC...) support the feature.
Thanks to the [Shortcut Badger library](https://github.com/leolin310148/ShortcutBadger/), ~ 16 launchers are supported.


### Dart

First, you just have to import the package in your dart files with:
```dart
import 'package:flutter_app_icon_badge/flutter_app_icon_badge.dart';
```

Then you can add a badge:
```dart
FlutterAppIconBadge.updateBadge(1);
```

Remove a badge:
```dart
FlutterAppIconBadge.removeBadge();
```

Or just check if the device supports this feature with:
```dart
FlutterAppIconBadge.isAppBadgeSupported();
```

Another useful method in this plugin - detect if flutter desktop window in focus or not:
```dart
FlutterAppIconBadge.isAppBadgeSupported();
```