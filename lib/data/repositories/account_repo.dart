import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/data/endpoints.dart';
import 'package:hog_v2/data/models/app_response.dart';
import 'package:hog_v2/data/models/user_model.dart';
import 'package:hog_v2/data/providers/apiProvider/api_provider.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';

class AccountRepo {
  Future<AppResponse> userLogin(User model) async {
    try {
      var response = await GetIt.instance<ApiProvider>().post(
        url: loginUrl,
        body: model.loginUserToJson(),
      );
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

  Future<AppResponse> userRegister(User model) async {
    try {
      var response = await GetIt.instance<ApiProvider>().post(
        url: registerUrl,
        body: model.registerUserToJson(),
      );
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

  Future<AppResponse> signOut() async {
    try {
      final response = await GetIt.instance<ApiProvider>().post(
        url: logOutUrl,
        token: GetIt.instance<CacheProvider>().getAppToken(),
      );
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> deleteProfile() async {
    try {
      final response = await GetIt.instance<ApiProvider>().delete(
        url: '$deleteProfileUrl/${GetIt.instance<CacheProvider>().getUserId()}',
        token: GetIt.instance<CacheProvider>().getAppToken(),
      );
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getMyProfile() async {
    try {
      final response = await GetIt.instance<ApiProvider>().get(
        url: getProfileUrl,
        token: GetIt.instance<CacheProvider>().getAppToken(),
      );
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    } on HttpException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> updateProfile(User user) async {
    Map<String, dynamic> toJson = await user.updateUserToJSon();
    try {
      final response = await GetIt.instance<ApiProvider>().post(
          url: "$updateProfileUrl/${user.id}",
          token: GetIt.instance<CacheProvider>().getAppToken(),
          body: FormData.fromMap(toJson));
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    }
  }

  Future<AppResponse> getScreenShoots() async {
    try {
      final response = await GetIt.instance<ApiProvider>().get(
        url: getScreenShootsUrl,
      );
      return AppResponse(
        errorMessage: null,
        data: response.data,
        success: true,
      );
    } on DioException catch (e) {
      return AppResponse(
        errorMessage: e.message ?? e.toString(),
        data: null,
        success: false,
      );
    } on HttpException catch (e) {
      return AppResponse(
        errorMessage: e.message,
        data: null,
        success: false,
      );
    }
  }
}
