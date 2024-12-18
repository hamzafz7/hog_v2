import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/presentation/homepage/controller/home_controller.dart';
import 'package:hog_v2/presentation/homepage/widgets/home_course_item.dart';

class YearsCoursesPage extends GetView<HomeController> {
  const YearsCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAllNamed(AppRoute.mainPageRoute);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "${controller.categoriesModel!.categories![controller.currentCategoryIndex].name}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    const Text("يتضمن هذا القسم"),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 101.w,
                      height: 36.h,
                      decoration: ShapeDecoration(
                        color: ksecondaryBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.coursesModel!.courses!.length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: kprimaryBlueColor),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Text("كورسات")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36.h,
              ),
            ),
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
              ),
              itemBuilder: (context, index) {
                return HomeCourseItem(
                  courseModel: controller.coursesModel!.courses![index],
                );
              },
              itemCount: controller.coursesModel!.courses!.length,
            ),
          ],
        ),
      ),
    );
  }
}
