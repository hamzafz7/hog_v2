import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/data/endpoints.dart';
import 'package:hog_v2/data/providers/apiProvider/interceptor.dart';
import 'package:hog_v2/data/repositories/account_repo.dart';

// ignore: library_prefixes

class ApiProvider {
  Dio? dio;

  init() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      ),
    );
    dio!.interceptors.add(
      AppInterceptors(
        dio: dio,
        repo: GetIt.instance<AccountRepo>(),
      ),
    );
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    String token = "",
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };

    return await dio!.get(url, queryParameters: query);
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    Object? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    print("Post body: ${body.toString()}");
    return await dio!.post(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.patch(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: body,
    );
  }
}
