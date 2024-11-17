import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hog_v2/offline_videos_feature/presentation/pages/offline_videos_page.dart';
import 'package:hog_v2/presentation/homepage/pages/home_page.dart';
import 'package:hog_v2/presentation/profile/pages/my_profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPageController extends GetxController {
  // int currentIndex = 1;
  // final pages = [
  //   KeepAlivePage(child: const MyProfilePage()),
  //   KeepAlivePage(child: const HomePage()),
  //   KeepAlivePage(child: const OfflineVideosPage())
  // ];
  //
  // PageController pageController = PageController(initialPage: 1);
  //
  // void changeTab(int index) {
  //   currentIndex = index;
  //   pageController.jumpToPage(index);
  //   update(['pages']);
  // }
  //
  // @override
  // void onClose() {
  //   pageController.dispose();
  //   // Dispose of any resources used by the pages
  //   super.onClose();
  // }

  int currentPageIndex = 1;
  PersistentTabController bottomNavController = PersistentTabController(initialIndex: 1);

  changeCurrentPage(int ind) {
    currentPageIndex = ind;
  }

  List<Widget> screens = [const MyProfilePage(), const HomePage(), const OfflineVideosPage()];
}
