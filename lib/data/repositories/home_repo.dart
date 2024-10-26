// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/data/endpoints.dart';
import 'package:hog_v2/data/models/app_response.dart';
import 'package:hog_v2/data/providers/apiProvider/api_provider.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';

class HomeRepository {
  Future<AppResponse> getNews() async {
    try {
      var appResponse = await GetIt.instance<ApiProvider>()
          .get(url: newsUrl, token: GetIt.instance<CacheProvider>().getAppToken());
      return AppResponse(success: true, errorMessage: null, data: appResponse.data);
    } on DioException catch (e, s) {
      if (kDebugMode) {
        print("Exception: $e \n $s");
      }
      return AppResponse(success: false, errorMessage: e.message ?? e.toString(), data: null);
    } catch (e, s) {
      if (kDebugMode) {
        print("Exception: $e \n $s");
      }
      return AppResponse(
        errorMessage: 'خطأ غير متوقع, يرجا المحاولة لاحقا',
        data: null,
        success: false,
      );
    }
  }
}
