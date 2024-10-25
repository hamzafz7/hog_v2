import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/data/models/courses_model.dart';
import 'package:hog_v2/data/repositories/category_repo.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final CategoryRepository _categoryRepository = CategoryRepository();

  @override
  void onClose() {
    searchController.dispose();
    courseStatus.close();
    super.onClose();
  }

  var courseStatus = RequestStatus.begin.obs;
  updatecourseStatus(RequestStatus status) => courseStatus.value = status;
  CoursesModel? coursesModel;

  Future<void> searchCourse(String searchText) async {
    updatecourseStatus(RequestStatus.loading);
    var response = await _categoryRepository.searchCourses(searchText);
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
  }
}
