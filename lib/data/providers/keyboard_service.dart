import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract class KeyboardService {
  static const platform = MethodChannel('keyboard_channel');

  static Future<bool> showKeyboard() async {
    if (kDebugMode) {
      print('showKeyboard');
    }
    try {
      final bool? result = await platform.invokeMethod('showKeyboard');
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to show keyboard: ${e.message}');
      }
      return false;
    }
  }

  static Future<bool> hideKeyboard() async {
    if (kDebugMode) {
      print('hideKeyboard');
    }
    try {
      final bool? result = await platform.invokeMethod('hideKeyboard');
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to hide keyboard: ${e.message}');
      }
      return false;
    }
  }

  static Future<bool> isKeyboardVisible() async {
    if (kDebugMode) {
      print('isKeyboardVisible');
    }
    try {
      final bool? result = await platform.invokeMethod('isKeyboardVisible');
      if (kDebugMode) {
        print('isKeyboardVisible : ${result ?? false}');
      }
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to check keyboard visibility: ${e.message}');
      }
      return false;
    }
  }
}
