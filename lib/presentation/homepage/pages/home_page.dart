import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/presentation/homepage/controller/home_controller.dart';
import 'package:hog_v2/presentation/homepage/widgets/courses.dart';
import 'package:hog_v2/presentation/homepage/widgets/home_stack_header.dart';
import 'package:hog_v2/presentation/homepage/widgets/year_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: kprimaryBlueColor,
        onRefresh: () async {
          homeController.getNews();
          homeController.getCategories();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: Get.width, child: HomeStackHeader()),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text('التصنيفات الرئيسية',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20.sp, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 70.h,
                  child:
                      Obx(() => switch (homeController.categoriesStatus.value) {
                            RequestStatus.success =>
                              homeController.categoriesModel != null &&
                                      homeController.categoriesModel!
                                          .categories!.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController
                                          .categoriesModel!.categories!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: YearButton(
                                            index: index,
                                            onPressed: () {
                                              homeController.changeCurrentIndex(
                                                  index,
                                                  homeController
                                                      .categoriesModel!
                                                      .categories![index]
                                                      .id!);
                                            },
                                            categoryModel: homeController
                                                .categoriesModel!
                                                .categories![index],
                                          ),
                                        );
                                      })
                                  : Container(),
                            RequestStatus.begin => Container(),
                            RequestStatus.loading => Center(
                                child: appCircularProgress(),
                              ),
                            RequestStatus.onError => const Center(
                                child: SizedBox(
                                    height: 70, child: Text("حدث خطأ")),
                              ),
                            RequestStatus.noData => const Center(
                                child: SizedBox(
                                    height: 70, child: Text("لا يوجد بيانات")),
                              ),
                            RequestStatus.noInternentt => const Center(
                                child: Text("لا يوجد اتصال بالانترنت"),
                              ),
                          }),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(() => switch (homeController.courseStatus.value) {
                      RequestStatus.success =>
                        homeController.coursesModel!.courses!.isNotEmpty ||
                                homeController.coursesModel!.courses != null
                            ? CoursesWidget()
                            : Container(),
                      RequestStatus.begin => Container(),
                      RequestStatus.loading => Center(
                          child: appCircularProgress(),
                        ),
                      RequestStatus.onError => const Center(
                          child: Text("حدث خطأ"),
                        ),
                      RequestStatus.noData => const Center(
                          child: Text("لا يوجد بيانات"),
                        ),
                      RequestStatus.noInternentt => const Center(
                          child: Text("لا يوجد اتصال بالانترنت"),
                        ),
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
