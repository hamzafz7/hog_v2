import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      printError(info: 'MainPage Build');
    }
    return GetBuilder<ThemeController>(
      id: "appTheme",
      builder: (cnt) {
        if (kDebugMode) {
          printError(info: 'appTheme Build');
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  // Check if we're on the first tab, then allow exit
                  if (controller.bottomNavController.index == 1) {
                    Get.back();
                  } else {
                    // Navigate back to the first tab instead of closing the app
                    controller.bottomNavController.jumpToTab(1);
                  }
                }
              },
              //   child: PageView(
              //     physics: NeverScrollableScrollPhysics(),
              //     controller: controller.pageController,
              //     onPageChanged: controller.changeTab,
              //     children: controller.pages,
              //   ),
              // ),
              // bottomNavigationBar: BottomNavigationBar(
              //   currentIndex: controller.currentIndex,
              //   onTap: controller.changeTab,
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: Icon(
              //         Icons.person,
              //         color: controller.currentIndex == 0 ? kprimaryBlueColor : Colors.grey,
              //       ),
              //       label: "حسابي",
              //       backgroundColor: controller.currentIndex == 0 ? kprimaryBlueColor : Colors.grey,
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(
              //         Icons.home,
              //         color: controller.currentIndex == 1 ? kprimaryBlueColor : Colors.grey,
              //       ),
              //       label: "الرئيسية",
              //       backgroundColor: controller.currentIndex == 1 ? kprimaryBlueColor : Colors.grey,
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(
              //         Icons.message,
              //         color: controller.currentIndex == 2 ? kprimaryBlueColor : Colors.grey,
              //       ),
              //       label: "كورساتي",
              //       backgroundColor: controller.currentIndex == 2 ? kprimaryBlueColor : Colors.grey,
              //     ),
              //   ],
              // ),
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
          ),
        );
      },
    );
  }
}
//
// class KeepAlivePage extends StatefulWidget {
//   final Widget child;
//
//   const KeepAlivePage({
//     super.key,
//     required this.child,
//   });
//
//   @override
//   State<KeepAlivePage> createState() => _KeepAlivePageState();
// }
//
// class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return widget.child;
//   }
// }
