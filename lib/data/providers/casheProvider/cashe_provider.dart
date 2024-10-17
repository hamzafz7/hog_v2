import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CacheProvider {
  static late GetStorage _getStorage;

  CacheProvider() {
    _getStorage = GetStorage();
  }
  static init() {
    _getStorage = GetStorage();
  }

  static getIsOnBoardingOpened() {
    return _getStorage.read("onboarding");
  }

  setIsOnBoardingOpened(bool value) {
    return _getStorage.write("onboarding", value);
  }

  static getAppToken() {
    return _getStorage.read("token");
  }

  static setUserName(String? name) {
    _getStorage.write("name", name);
  }

  static setUserId(int? id) {
    _getStorage.write("id", id);
  }

  static getUserId() {
    return _getStorage.read("id");
  }

  static setUserImage(String? image) {
    _getStorage.write("image", image);
  }

  static getUserImage() {
    return _getStorage.read("image");
  }

  static setAppToken(String val) {
    _getStorage.write("token", val);
  }

  static clearAppToken() {
    _getStorage.remove("token");
  }

  static getUserName() {
    return _getStorage.read("name");
  }

  static setUserPhone(String? val) {
    _getStorage.write("phone", val);
  }

  static getUserPhone() {
    return _getStorage.read("phone");
  }

  getDeviceId() {
    return _getStorage.read("device_id");
  }

  static bool getAppTheme() {
    return _getStorage.read("is_Dark") ?? false;
  }

  static setAppTheme(bool val) {
    _getStorage.write("is_Dark", val);
  }

  static setdeviceToken(String? val) {
    _getStorage.write("device_token", val);
  }

  static getdeviceToken() {
    return _getStorage.read("device_token");
  }

  static setUserType(String? val) {
    _getStorage.write("type", val);
  }

  static getUserType() {
    return _getStorage.read("type");
  }

  Future<void> setDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
   const _androidIdPlugin = AndroidId();

      final String? androidId = await _androidIdPlugin.getId();
      await _getStorage.write("device_id", androidId);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      await _getStorage.write("device_id", iosInfo.identifierForVendor);
    }
  }
}
