import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/offline_videos_feature/presentation/pages/offline_videos_page.dart';
import 'package:hog_v2/presentation/homepage/pages/home_page.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';
import 'package:hog_v2/presentation/profile/pages/my_profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPageController extends GetxController {
  int currentPageIndex = 1;
  PersistentTabController bottomNavController = PersistentTabController(initialIndex: 1);

  changeCurrentPage(int ind) {
    if (ind == 0 && !Get.isRegistered<MyProfileController>()) {
      Get.put(MyProfileController());
    }
    currentPageIndex = ind;
  }

  List<Widget> screens = [const MyProfilePage(), const HomePage(), const OfflineVideosPage()];
}
