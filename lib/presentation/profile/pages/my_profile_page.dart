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

// ignore: must_be_immutable
class MyProfilePage extends StatelessWidget {
  MyProfilePage({super.key});
  final profileController = Get.put(MyProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: kprimaryBlueColor,
        onRefresh: () async {
          Get.find<MyProfileController>().getMyProfile();
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              const MyProfileHeader(),
              SizedBox(
                height: 25.h,
              ),
              Obx(
                () => Get.find<MyProfileController>().getProfileStatus.value ==
                        RequestStatus.loading
                    ? Center(
                        child: appCircularProgress(),
                      )
                    : Get.find<MyProfileController>().getProfileStatus.value ==
                            RequestStatus.onError
                        ? const Center(
                            child: Text("حدث خطأ"),
                          )
                        : Get.find<MyProfileController>().getProfileStatus.value ==
                                RequestStatus.noInternentt
                            ? const Center(
                                child: Text("لا يوجد اتصال في الإننرنت"),
                              )
                            : Column(
                                children: [
                                  MyProfileImage(),
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
                                  Obx(
                                    () => Get.find<MyProfileController>().logOutStatus.value ==
                                            RequestStatus.loading
                                        ? appCircularProgress()
                                        : ProfileListItem(
                                            svgUrl: "assets/icons/log-out.svg",
                                            onTap: () {
                                              CustomDialog(context,
                                                  child: LogOutDialog(onPressed: () {
                                                Get.find<MyProfileController>().logOut();

                                                Get.back();
                                              }), height: 250, width: 390);
                                            },
                                            text: "تسجيل الخروج"),
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
                                      GetBuilder(
                                          init: ThemeController(),
                                          builder: (cnt) {
                                            return Switch.adaptive(
                                                activeColor: Colors.blue,
                                                inactiveThumbColor: Colors.blue,
                                                trackOutlineColor:
                                                    MaterialStateProperty.resolveWith(
                                                        (states) => Colors.blue),
                                                value: cnt.currentTheme == ThemeMode.dark,
                                                onChanged: (val) {
                                                  cnt.switchTheme();
                                                  Get.changeThemeMode(cnt.currentTheme);
                                                });
                                          }),
                                      SizedBox(
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Obx(
                                    () =>
                                        Get.find<MyProfileController>().deleteProfileStatus.value ==
                                                RequestStatus.loading
                                            ? appCircularProgress()
                                            : ProfileListItem(
                                                svgUrl: "assets/icons/x.svg",
                                                onTap: () {
                                                  CustomDialog(context,
                                                      child: DeleteProfileDialog(onPressed: () {
                                                    Get.find<MyProfileController>().deleteProfile();

                                                    Get.back();
                                                  }), height: 250, width: 390);
                                                },
                                                text: "حذف الحساب"),
                                  )
                                ],
                              ),
              ),
            ])),
      ),
    );
  }
}
