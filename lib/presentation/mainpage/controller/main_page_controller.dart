import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/offline_videos_feature/presentation/pages/offline_videos_page.dart';
import 'package:hog_v2/presentation/homepage/pages/home_page.dart';
import 'package:hog_v2/presentation/profile/pages/my_profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPageController extends GetxController {
  @override
  void onClose() {
    currentPageIndex.close();
    super.onClose();
  }

  RxInt currentPageIndex = 1.obs;
  PersistentTabController bottomNavController = PersistentTabController(initialIndex: 1);
  changeCurrentPage(int ind) {
    currentPageIndex.value = ind;
  }

  List<Widget> screens = [MyProfilePage(), HomePage(), const OfflineVideosPage()];
}
