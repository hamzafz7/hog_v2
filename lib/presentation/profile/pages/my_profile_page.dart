import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/controllers/themeController.dart';
import 'package:hog_v2/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:hog_v2/presentation/custom_dialogs/delete_account_dialog.dart';
import 'package:hog_v2/presentation/custom_dialogs/log-out.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';
import 'package:hog_v2/presentation/profile/widgets/my_profile_header.dart';
import 'package:hog_v2/presentation/profile/widgets/my_profile_image.dart';
import 'package:hog_v2/presentation/profile/widgets/profile_list_item.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      printError(info: 'MyProfilePage Build');
    }
    return Scaffold(
      body: RefreshIndicator(
        color: kprimaryBlueColor,
        onRefresh: () async {
          await controller.getMyProfile();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const MyProfileHeader(),
            SizedBox(
              height: 25.h,
            ),
            GetBuilder<MyProfileController>(
              id: "profilePage",
              builder: (_) {
                if (kDebugMode) {
                  printError(info: 'profilePage Build');
                }
                return controller.getProfileStatus == RequestStatus.loading
                    ? Center(
                        child: appCircularProgress(),
                      )
                    : controller.getProfileStatus == RequestStatus.onError
                        ? const Center(
                            child: Text("حدث خطأ"),
                          )
                        : controller.getProfileStatus == RequestStatus.noInternentt
                            ? const Center(
                                child: Text("لا يوجد اتصال في الإننرنت"),
                              )
                            : Column(
                                children: [
                                  const MyProfileImage(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(GetIt.instance<CacheProvider>().getUserName() ?? " ",
                                      style: Theme.of(context).textTheme.bodyLarge),
                                  SizedBox(
                                    height: 45.h,
                                  ),
                                  ProfileListItem(
                                      svgUrl: "assets/icons/person.svg",
                                      onTap: () {
                                        Get.toNamed(AppRoute.userInfoPageRoute);
                                      },
                                      text: "الملف الشخصي"),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  ProfileListItem(
                                      svgUrl: "assets/icons/settings.svg",
                                      onTap: () {
                                        Get.toNamed(AppRoute.settingsPageRoute);
                                      },
                                      text: "الإعدادات"),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  GetBuilder<MyProfileController>(
                                    id: "logoutButton",
                                    builder: (_) {
                                      if (kDebugMode) {
                                        printError(info: 'logoutButton Build');
                                      }
                                      return controller.logOutStatus == RequestStatus.loading
                                          ? appCircularProgress()
                                          : ProfileListItem(
                                              svgUrl: "assets/icons/log-out.svg",
                                              onTap: () {
                                                customDialog(
                                                  context,
                                                  child: LogOutDialog(
                                                    onPressed: () {
                                                      controller.logOut();
                                                      Get.back();
                                                    },
                                                  ),
                                                  height: 250,
                                                  width: 390,
                                                );
                                              },
                                              text: "تسجيل الخروج",
                                            );
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    children: [
                                      ProfileListItem(
                                          svgUrl: "assets/icons/sun.svg",
                                          onTap: () {},
                                          text: "الوضع الليلي"),
                                      const Spacer(),
                                      GetBuilder<ThemeController>(
                                        id: "switchThemeButton",
                                        builder: (cnt) {
                                          if (kDebugMode) {
                                            printError(info: 'switchThemeButton Build');
                                          }
                                          return Switch.adaptive(
                                              activeColor: Colors.blue,
                                              inactiveThumbColor: Colors.blue,
                                              trackOutlineColor: WidgetStateProperty.resolveWith(
                                                  (states) => Colors.blue),
                                              value: cnt.currentTheme == ThemeMode.dark,
                                              onChanged: (val) {
                                                cnt.switchTheme();
                                              });
                                        },
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  GetBuilder<MyProfileController>(
                                    id: "deleteProfileButton",
                                    builder: (_) {
                                      if (kDebugMode) {
                                        printError(info: 'deleteProfileButton Build');
                                      }
                                      return controller.deleteProfileStatus == RequestStatus.loading
                                          ? appCircularProgress()
                                          : ProfileListItem(
                                              svgUrl: "assets/icons/x.svg",
                                              onTap: () {
                                                customDialog(
                                                  context,
                                                  child: DeleteProfileDialog(
                                                    onPressed: () {
                                                      controller.deleteProfile();
                                                      Get.back();
                                                    },
                                                  ),
                                                  height: 250,
                                                  width: 390,
                                                );
                                              },
                                              text: "حذف الحساب",
                                            );
                                    },
                                  )
                                ],
                              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
