import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';

class ProgressHeaderWidget extends GetView<QuizController> {
  const ProgressHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GetBuilder<QuizController>(builder: (_) {
            return LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10.r),
              value: controller.initalValue,
              minHeight: 10,
              valueColor: const AlwaysStoppedAnimation(kprimaryBlueColor),
              backgroundColor: Colors.grey[100],
              color: kprimaryBlueColor,
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GetBuilder<QuizController>(builder: (_) {
                return Text(
                  " ${controller.currentQuistions}س",
                  style: const TextStyle(color: Colors.red),
                );
              }),
              const Text(
                " /",
                style: TextStyle(color: kprimaryBlueColor),
              ),
              GetBuilder<QuizController>(builder: (_) {
                return Text(
                  " ${controller.totalQuistions}س",
                  style: const TextStyle(color: kprimaryBlueColor),
                );
              }),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Text(
                    " ${controller.formattedTime.value}  دقيقة متبقية",
                    style: const TextStyle(color: kprimaryBlueColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
