import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/controllers/themeController.dart';
import 'package:hog_v2/presentation/mainpage/controller/main_page_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainPageController = Get.find<MainPageController>();

    return Scaffold(
      extendBody: true,
      body: GetBuilder(
        init: ThemeController(),
        // ignore: deprecated_member_use
        builder: (cnt) => WillPopScope(
          onWillPop: () async {
            // Check if we're on the first tab, then allow exit
            if (mainPageController.bottomNavController.index == 0) {
              // exit(0);
              return true; // Allow app to close
            } else {
              // Navigate back to the first tab instead of closing the app
              mainPageController.bottomNavController.jumpToTab(0);
              return false; // Prevent app from closing
            }
          },
          child: PersistentTabView(
            context,
            controller: mainPageController.bottomNavController,
            backgroundColor: cnt.currentTheme == ThemeMode.dark
                ? const Color.fromARGB(255, 7, 37, 61)
                : Colors.white,
            screens: mainPageController.screens,
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
      ),
    );
  }
}
