import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/data/endpoints.dart';
import 'package:hog_v2/data/models/app_response.dart';
import 'package:hog_v2/data/providers/apiProvider/api_provider.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';

class CategoryRepository {
  Future<AppResponse> getCategories() async {
    try {
      var response = await GetIt.instance<ApiProvider>()
          .get(url: categoriesUrl, token: GetIt.instance<CacheProvider>().getAppToken());
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getCourses(int id) async {
    String? os;
    if (Platform.isIOS)
      os = "ios";
    else {
      os = "android";
    }
    try {
      var response = await GetIt.instance<ApiProvider>()
          .get(url: "$coursesUrl/$id", token: GetIt.instance<CacheProvider>().getAppToken() ?? "", query: {"os": os});
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> searchCourses(String searchText) async {
    try {
      var response = await GetIt.instance<ApiProvider>().get(
          url: searchCoursesUrl, token: GetIt.instance<CacheProvider>().getAppToken(), query: {"search": searchText});
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getCourseInfo(int id) async {
    String? os;
    if (Platform.isIOS)
      os = "ios";
    else {
      os = "android";
    }
    try {
      var response = await GetIt.instance<ApiProvider>()
          .get(url: "$showCourseUrl/$id", token: GetIt.instance<CacheProvider>().getAppToken(), query: {"os": os});
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getMyCourses(int id) async {
    try {
      var response = await GetIt.instance<ApiProvider>()
          .get(url: "users/$id/courses", token: GetIt.instance<CacheProvider>().getAppToken());
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> signInCourse(int id, String activationCode) async {
    try {
      var response = await GetIt.instance<ApiProvider>().post(
          url: "$signInCourseUrl/$id",
          token: GetIt.instance<CacheProvider>().getAppToken(),
          body: {"activation_code": activationCode});
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> watchVideo(String link, String source) async {
    try {
      print(GetIt.instance<CacheProvider>().getAppToken());
      var body = {"link": link, "source": source};
      print(body);

      var appResponse = await GetIt.instance<ApiProvider>()
          .post(url: watchVidUrl, token: GetIt.instance<CacheProvider>().getAppToken(), body: body);
      return AppResponse(success: true, data: appResponse.data, errorMessage: null);
    } on DioException catch (e) {
      return AppResponse(success: true, data: null, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> downloadVideo(String link, String source) async {
    try {
      var appResponse = await GetIt.instance<ApiProvider>().post(
          url: downloadVidUrl,
          token: GetIt.instance<CacheProvider>().getAppToken(),
          body: {"link": link, "source": source});
      return AppResponse(success: true, data: appResponse.data, errorMessage: null);
    } on DioException catch (e) {
      return AppResponse(success: true, data: null, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> isWatched(int id) async {
    try {
      var appResponse = await GetIt.instance<ApiProvider>().post(
        url: "$isWatchedUrl/$id",
        token: GetIt.instance<CacheProvider>().getAppToken(),
      );
      return AppResponse(success: true, data: appResponse.data, errorMessage: null);
    } on DioException catch (e) {
      return AppResponse(success: true, data: null, errorMessage: e.message ?? e.toString());
    }
  }
}
