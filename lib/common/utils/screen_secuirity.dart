import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScreenSecurity {
  MethodChannel platform = const MethodChannel('com.house_of_genuises/screen_security');

  // Call this method to enable or disable screenshot based on API response
  Future<void> toggleScreenSecurity(bool isSecure) async {
    try {
      await platform.invokeMethod('toggleScreenSecurity', {'isSecure': isSecure});
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to toggle screen security: '${e.message}'.");
      }
    }
  }
}
