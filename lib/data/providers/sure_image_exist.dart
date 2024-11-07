import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

abstract class SureImageExist {
  static Future<bool> checkImageAvailability(String imageUrl) async {
    return await compute(_calculate, imageUrl);
  }

  static Future<bool> _calculate(String imageUrl) async {
    try {
      if (kDebugMode) {
        print('--------------------');
        print('imageUrl: $imageUrl');
        print('--------------------');
      }
      final dio = DioClient.getClient();
      final response = await dio.get(
        imageUrl,
        options: Options(
          headers: {'Range': 'bytes=0-1'},
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );
      if (kDebugMode) {
        print('response.statusCode-------------------- ${response.statusCode}');
      }
      return response.statusCode == 200 || response.statusCode == 206;
    } catch (e) {
      if (kDebugMode) {
        print('Exception-------------------- $e');
      }
      return false;
    }
  }
}

class DioClient {
  static Dio getClient() {
    final dio = Dio();

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }
}
