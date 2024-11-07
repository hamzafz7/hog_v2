import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hog_v2/data/providers/keyboard_service.dart';

class KeyboardHandler extends StatefulWidget {
  final Widget child;

  const KeyboardHandler({super.key, required this.child});

  @override
  State<KeyboardHandler> createState() => _KeyboardHandlerState();
}

class _KeyboardHandlerState extends State<KeyboardHandler> {
  bool _isSamsung = false;

  @override
  void initState() {
    super.initState();
    _checkIfSamsungDevice();
    // FocusManager.instance.highlightStrategy =
  }

  Future<void> _checkIfSamsungDevice() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      setState(() {
        _isSamsung = androidInfo.manufacturer.toLowerCase() == 'samsung';
      });
    }
  }

  void _customSamsungKeyboardHandling() async {
    FocusManager.instance.addListener(() async {
      if (FocusManager.instance.primaryFocus == null || await KeyboardService.isKeyboardVisible()) {
        KeyboardService.hideKeyboard();
      } else {
        KeyboardService.showKeyboard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSamsung) {
      _customSamsungKeyboardHandling();
    }
    return widget.child;
  }
}
