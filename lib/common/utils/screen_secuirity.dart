import 'package:flutter/services.dart';

class ScreenSecurity {
  static const platform =
      MethodChannel('com.house_of_genuises/screen_security');

  // Call this method to enable or disable screenshot based on API response
  static Future<void> toggleScreenSecurity(bool isSecure) async {
    try {
      await platform
          .invokeMethod('toggleScreenSecurity', {'isSecure': isSecure});
    } on PlatformException catch (e) {
      print("Failed to toggle screen security: '${e.message}'.");
    }
  }
}
