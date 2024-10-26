import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/homepage/controller/home_controller.dart';
import 'package:hog_v2/presentation/homepage/widgets/home_course_item.dart';

class YearsCoursesPage extends GetView<HomeController> {
  const YearsCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "${controller.categoriesModel!.categories![controller.currentCategoryIndex].name}",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Divider(),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
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
          SizedBox(
            height: 36.h,
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.7,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.coursesModel!.courses!.length,
            itemBuilder: (context, index) {
              return HomeCourseItem(
                courseModel: controller.coursesModel!.courses![index],
              );
            },
          )
        ]),
      ),
    );
  }
}
