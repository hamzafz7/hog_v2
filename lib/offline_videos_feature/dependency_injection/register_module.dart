import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  /// Adding the [Dio] instance to the graph to be later used by the local data sources
  @lazySingleton
  Dio dio(SharedPreferences sharedPreferences) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        responseType: ResponseType.plain,
      ),
    );

    // dio.interceptors.add(
    //   LogInterceptor(
    //       responseBody: true,
    //       requestBody: true,
    //       responseHeader: true,
    //       requestHeader: true,
    //       request: true,
    //       logPrint: ((message) => log(message.toString()))),
    // );

    return dio;
  }

  /// Adding the [SharedPreferences] instance to the graph to be later used by the local data sources
  @lazySingleton
  Future<SharedPreferences> get prefs async {
    return await SharedPreferences.getInstance();
  }

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
