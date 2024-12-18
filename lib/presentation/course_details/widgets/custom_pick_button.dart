import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog_v2/presentation/widgets/custom_button.dart';

class CustomPickButton extends GetView<CourseDetailsController> {
  const CustomPickButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Container(
        width: 382.w,
        height: 65.h,
        decoration: ShapeDecoration(
          color: ksecondaryBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CourseDetailsController>(
              builder: (_) => CustomButton(
                bottomColor: controller.currentWidgetIndex == 0
                    ? kprimaryBlueColor
                    : ksecondaryBlueColor.withOpacity(0.008),
                width: 110.w,
                height: 48.h,
                onTap: () {
                  controller.changeCurrentWidgetIndex(0);
                },
                borderRadius: 13.r,
                child: Text(
                  "الوصف",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          //  controller.currentWidgetIndex.value == 0
                          // ?
                          Colors.white
                      // : kDarkBlueColor
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            GetBuilder<CourseDetailsController>(
              builder: (_) => CustomButton(
                bottomColor: controller.currentWidgetIndex == 1
                    ? kprimaryBlueColor
                    : ksecondaryBlueColor.withOpacity(0.008),
                width: 110.w,
                height: 48.h,
                onTap: () {
                  controller.changeCurrentWidgetIndex(1);
                },
                borderRadius: 13.r,
                child: Text("المنهاج",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            //  controller.currentWidgetIndex.value == 1
                            // ?
                            Colors.white
                        // : kDarkBlueColor
                        )),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            GetBuilder<CourseDetailsController>(
              builder: (_) => CustomButton(
                bottomColor: controller.currentWidgetIndex == 2
                    ? kprimaryBlueColor
                    : ksecondaryBlueColor.withOpacity(0.008),
                width: 110.w,
                height: 48.h,
                onTap: () {
                  controller.changeCurrentWidgetIndex(2);
                },
                borderRadius: 13.r,
                child: Text("المحفوظات",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            //  controller.currentWidgetIndex.value == 1
                            // ?
                            Colors.white
                        // : kDarkBlueColor
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
