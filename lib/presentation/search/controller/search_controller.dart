import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/data/models/courses_model.dart';
import 'package:hog_v2/data/repositories/category_repo.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final CategoryRepository _categoryRepository = CategoryRepository();
  CancelToken cancelToken = CancelToken();
  Timer? debounceTimer;

  @override
  void onClose() {
    searchController.dispose();
    debounceTimer?.cancel();
    super.onClose();
  }

  var courseStatus = RequestStatus.begin;

  updatecourseStatus(RequestStatus status) {
    courseStatus = status;
    update(["SearchPage"]);
  }

  CoursesModel? coursesModel;

  void searchCourse(String searchText) {
    updatecourseStatus(RequestStatus.loading);
    _categoryRepository.searchCourses(searchText, cancelToken).then((response) {
      if (response.success) {
        coursesModel = CoursesModel.fromJson(response.data);
        if (coursesModel!.courses == null || coursesModel!.courses!.isEmpty) {
          updatecourseStatus(RequestStatus.noData);
        } else {
          updatecourseStatus(RequestStatus.success);
        }
      } else if (!response.success) {
        if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
          updatecourseStatus(RequestStatus.noInternentt);
        } else {
          updatecourseStatus(RequestStatus.onError);
        }
      }
    });
  }
}
