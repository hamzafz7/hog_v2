import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CacheProvider {
  late GetStorage _getStorage;

  init() {
    _getStorage = GetStorage();
  }

  getIsOnBoardingOpened() {
    return _getStorage.read("onboarding");
  }

  setIsOnBoardingOpened(bool value) {
    return _getStorage.write("onboarding", value);
  }

  getAppToken() {
    return _getStorage.read("token");
  }

  setUserName(String? name) {
    _getStorage.write("name", name);
  }

  setUserId(int? id) {
    _getStorage.write("id", id);
  }

  getUserId() {
    return _getStorage.read("id");
  }

  setUserImage(String? image) {
    _getStorage.write("image", image);
  }

  getUserImage() {
    return _getStorage.read("image");
  }

  setAppToken(String val) {
    _getStorage.write("token", val);
  }

  clearAppToken() {
    _getStorage.remove("token");
  }

  getUserName() {
    return _getStorage.read("name");
  }

  setUserPhone(String? val) {
    _getStorage.write("phone", val);
  }

  getUserPhone() {
    return _getStorage.read("phone");
  }

  getDeviceId() {
    return _getStorage.read("device_id");
  }

  bool getAppTheme() {
    return _getStorage.read("is_Dark") ?? false;
  }

  setAppTheme(bool val) {
    _getStorage.write("is_Dark", val);
  }

  setdeviceToken(String? val) {
    _getStorage.write("device_token", val);
  }

  getdeviceToken() {
    return _getStorage.read("device_token");
  }

  setUserType(String? val) {
    _getStorage.write("type", val);
  }

  getUserType() {
    return _getStorage.read("type");
  }

  Future<void> setDeviceId(String uuid) async {
    await _getStorage.write("device_id", uuid);
  }

  Future<String> createUUID({String? phone, BuildContext? context}) async {
    late String uuid;
    String phoneNo = phone ?? "";
    String width = MediaQuery.sizeOf(context!).width.toString();
    String height = MediaQuery.sizeOf(context).height.toString();
    late String model;
    late String manufacturer;
    late String osVersion;
    late String os;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      os = 'Android';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
      manufacturer = androidInfo.manufacturer + androidInfo.device;
      osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      os = 'IOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
      manufacturer = 'Apple';
      osVersion = iosInfo.systemVersion;
      if (kDebugMode) {
        print('Device Model: ${iosInfo.utsname.machine}');
      }
    }
    Map data = {
      'phoneNo': phoneNo,
      'width': width,
      'height': height,
      'model': model,
      'manufacturer': manufacturer,
      'osVersion': osVersion,
      'os': os,
    };
    uuid = EncryptionService().encryptData(jsonEncode(data));
    if (kDebugMode) {
      print('Signed token: $uuid\n');
    }

    if (kDebugMode) {
      print("create uuid: $uuid");
    }

    await setDeviceId(uuid);
    if (kDebugMode) {
      print("save uuid");
    }

    return uuid;
  }
}

class EncryptionService {
  final String key = 'a1b2c3dy9lf6g7h8';
  final String iv = 'initva3nor123456';

  String encryptData(String data) {
    final keyBytes = encrypt.Key.fromUtf8(key);
    final ivBytes = encrypt.IV.fromUtf8(iv);

    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));

    final encrypted = encrypter.encrypt(data, iv: ivBytes);

    return encrypted.base64;
  }

  String decryptData(String encryptedData) {
    final keyBytes = encrypt.Key.fromUtf8(key);
    final ivBytes = encrypt.IV.fromUtf8(iv);

    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));

    final decrypted = encrypter.decrypt64(encryptedData, iv: ivBytes);

    return decrypted;
  }
}
