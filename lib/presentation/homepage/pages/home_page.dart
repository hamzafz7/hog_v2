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

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    printError(info: 'HomePage Build');
    return SafeArea(
      child: RefreshIndicator(
        color: kprimaryBlueColor,
        onRefresh: () async {
          await Future.wait([controller.getNews(), controller.getCategories()]);
        },
        child: Scaffold(
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const HomeStackHeader(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text('التصنيفات الرئيسية',
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 70.h,
                  child: GetBuilder<HomeController>(
                      id: "categoriesSection",
                      builder: (_) {
                        printError(info: 'categoriesSection Build');
                        return switch (controller.categoriesStatus) {
                          RequestStatus.success =>
                            controller.categoriesModel?.categories?.isNotEmpty == true
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.categoriesModel!.categories!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0.r),
                                        child: YearButton(
                                          index: index,
                                          onPressed: () {
                                            controller.changeCurrentIndex(index,
                                                controller.categoriesModel!.categories![index].id!);
                                          },
                                          categoryModel:
                                              controller.categoriesModel!.categories![index],
                                        ),
                                      );
                                    })
                                : const SizedBox.shrink(),
                          RequestStatus.begin => Container(),
                          RequestStatus.loading => Center(
                              child: appCircularProgress(),
                            ),
                          RequestStatus.onError => const Center(
                              child: SizedBox(height: 70, child: Text("حدث خطأ")),
                            ),
                          RequestStatus.noData => const Center(
                              child: SizedBox(height: 70, child: Text("لا يوجد بيانات")),
                            ),
                          RequestStatus.noInternentt => const Center(
                              child: Text("لا يوجد اتصال بالانترنت"),
                            ),
                        };
                      }),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30.h,
                ),
              ),
              SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "coursesSection",
                    builder: (_) {
                      printError(info: 'coursesSection Build');
                      return switch (controller.courseStatus) {
                        RequestStatus.success => controller.coursesModel != null &&
                                controller.coursesModel!.courses != null &&
                                controller.coursesModel!.courses!.isNotEmpty
                            ? const CoursesWidget()
                            : const SizedBox.shrink(),
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
                      };
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
