import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/data/models/categories_model.dart';
import 'package:hog_v2/data/models/courses_model.dart';
import 'package:hog_v2/data/models/news_model.dart';
import 'package:hog_v2/data/providers/sure_image_exist.dart';
import 'package:hog_v2/data/repositories/category_repo.dart';
import 'package:hog_v2/data/repositories/home_repo.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getNews();
    getCategories();
    super.onInit();
  }

  NewsResponse? newsResponse;
  CategoriesModel? categoriesModel;
  int currentCategoryIndex = 0;

  changeCurrentIndex(int ind, int courseId) {
    int i = currentCategoryIndex;
    currentCategoryIndex = ind;
    update(["changeCurrentIndex_$i"]);
    update(["changeCurrentIndex_$ind"]);
    getCourses(courseId);
  }

  var getNewsStatus = RequestStatus.begin;
  var categoriesStatus = RequestStatus.begin;

  updateGetNewsStatus(RequestStatus status) => getNewsStatus = status;

  var courseStatus = RequestStatus.begin;

  updatecourseStatus(RequestStatus status) => courseStatus = status;

  updateCategoriesStatus(RequestStatus status) => categoriesStatus = status;
  final HomeRepository _homeRepository = HomeRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  Future<void> getNews() async {
    updateGetNewsStatus(RequestStatus.loading);
    update(["newsSection"]);
    var response = await _homeRepository.getNews();
    if (response.success) {
      newsResponse = NewsResponse.fromJson(response.data);
      if (kDebugMode) {
        print('newsResponse?.news ${newsResponse?.news}');
      }
      if (newsResponse!.news.isEmpty) {
        updateGetNewsStatus(RequestStatus.noData);
      } else {
        ff().then((_) {
          updateGetNewsStatus(RequestStatus.success);
          update(["newsSection"]);
        });
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetNewsStatus(RequestStatus.noInternentt);
      } else {
        updateGetNewsStatus(RequestStatus.onError);
      }
    }
    update(["newsSection"]);
  }

  Future<void> ff() async {
    for (int i = 0; i < newsResponse!.news.length; i++) {
      if (newsResponse!.news[i].image != null && !(newsResponse!.news[i].imageExist ?? false)) {
        newsResponse!.news[i].imageExist =
            await SureImageExist.checkImageAvailability(newsResponse!.news[i].image!);
      }
    }
  }

  Future<void> getCategories() async {
    updateCategoriesStatus(RequestStatus.loading);
    update(["categoriesSection"]);
    var response = await _categoryRepository.getCategories();
    if (response.success) {
      categoriesModel = CategoriesModel.fromJson(response.data);
      if (categoriesModel!.categories == null || categoriesModel!.categories!.isEmpty) {
        updateCategoriesStatus(RequestStatus.noData);
      } else {
        updateCategoriesStatus(RequestStatus.success);
        getCourses(categoriesModel!.categories![0].id!);
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateCategoriesStatus(RequestStatus.noInternentt);
      } else {
        updateCategoriesStatus(RequestStatus.onError);
      }
    }
    update(["categoriesSection"]);
  }

  CoursesModel? coursesModel;

  Future<void> getCourses(int id) async {
    updatecourseStatus(RequestStatus.loading);
    update(["coursesSection"]);
    var response = await _categoryRepository.getCourses(id);
    if (response.success) {
      coursesModel = CoursesModel.fromJson(response.data);
      if (kDebugMode) {
        print(response.data);
      }
      if (coursesModel!.courses == null || coursesModel!.courses!.isEmpty) {
        updatecourseStatus(RequestStatus.noData);
      } else {
        dd().then((_) {
          updatecourseStatus(RequestStatus.success);
          update(["coursesSection"]);
        });
      }
    } else if (!response.success) {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updatecourseStatus(RequestStatus.noInternentt);
      } else {
        updatecourseStatus(RequestStatus.onError);
      }
    }
    update(["coursesSection"]);
  }

  Future<void> dd() async {
    for (int i = 0; i < coursesModel!.courses!.length; i++) {
      if (coursesModel!.courses![i].image != null &&
          !(coursesModel!.courses![i].imageExist ?? false)) {
        coursesModel!.courses![i].imageExist =
            await SureImageExist.checkImageAvailability(coursesModel!.courses![i].image!);
      }
    }
  }
}
