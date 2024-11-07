import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
        connectTimeout: const Duration(milliseconds: 50000),
        receiveTimeout: const Duration(milliseconds: 30000),
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
    CancelToken? cancelToken,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    if (kDebugMode) {
      print("Post body: ${query.toString()}");
    }
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
    if (kDebugMode) {
      print("Post body: ${body.toString()}");
    }
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
    if (kDebugMode) {
      print("Post body: ${body.toString()}");
    }
    if (kDebugMode) {
      print("Post query: ${query.toString()}");
    }
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
    if (kDebugMode) {
      print("Post body: ${body.toString()}");
    }
    if (kDebugMode) {
      print("Post query: ${query.toString()}");
    }
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
    if (kDebugMode) {
      print("Post body: ${body.toString()}");
    }
    if (kDebugMode) {
      print("Post query: ${query.toString()}");
    }
    return await dio!.delete(
      url,
      queryParameters: query,
      data: body,
    );
  }
}
