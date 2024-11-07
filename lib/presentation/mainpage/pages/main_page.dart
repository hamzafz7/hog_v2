import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/controllers/themeController.dart';
import 'package:hog_v2/presentation/mainpage/controller/main_page_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    printError(info: 'MainPage Build');
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      id: "appTheme",
      builder: (cnt) {
        printError(info: 'appTheme Build');
        return Scaffold(
          extendBody: true,
          // ignore: deprecated_member_use
          body: WillPopScope(
            onWillPop: () async {
              // Check if we're on the first tab, then allow exit
              if (controller.bottomNavController.index == 0) {
                // exit(0);
                return true; // Allow app to close
              } else {
                // Navigate back to the first tab instead of closing the app
                controller.bottomNavController.jumpToTab(0);
                return false; // Prevent app from closing
              }
            },
            child: PersistentTabView(
              context,
              controller: controller.bottomNavController,
              backgroundColor: cnt.currentTheme == ThemeMode.dark
                  ? const Color.fromARGB(255, 7, 37, 61)
                  : Colors.white,
              screens: controller.screens,
              items: [
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.person),
                  title: "حسابي",
                  activeColorPrimary: kprimaryBlueColor,
                  inactiveColorPrimary: Colors.grey,
                  inactiveColorSecondary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.home),
                  title: "الرئيسية",
                  activeColorPrimary: kprimaryBlueColor,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.message),
                  title: "كورساتي",
                  activeColorPrimary: kprimaryBlueColor,
                  inactiveColorPrimary: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
