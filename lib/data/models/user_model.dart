import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? password;
  final bool? isBlocked;
  final String? image;
  bool? imageExist;
  final String? type;
  final String? location;

  User(
      {this.id,
      this.imageExist,
      this.fullName,
      this.email,
      this.phone,
      this.isBlocked,
      this.type,
      this.password,
      this.image,
      this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      isBlocked: json['is_blocked'],
      type: json['type'],
      image: json['image'],
      imageExist: false,
    );
  }

  Map<String, dynamic> loginUserToJson(String device_id) {
     if (kDebugMode) {
      print("get device_id: $device_id");
    }
    return {
      "phone": phone,
      "password": password,
      "device_id": device_id,
      'device_notification_id': GetIt.instance<CacheProvider>().getdeviceToken()
    };
  }

  Future<Map<String, dynamic>> registerUserToJson(String device_id) async {
    if (kDebugMode) {
      print("get device_id: $device_id");
    }
    return {
      "full_name": fullName,
      "phone": phone,
      "password": password,
      "device_id": device_id,
      "email": "hamzafz888@gmail.com",
      'device_notification_id': GetIt.instance<CacheProvider>().getdeviceToken()
    };
  }

  Future<Map<String, dynamic>> updateUserToJSon() async {
    late File image1;
    if (image != null && image != "") {
      image1 = await GetIt.instance<Utils>().compressImage(File(image!)) ??
          File(image!);
    }
    return {
      "full_name": fullName,
      "phone": phone,
      if (image != null && image != "")
        'image': await MultipartFile.fromFile(image1.path)
    };
  }
}
