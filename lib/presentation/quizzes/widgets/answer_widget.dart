import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/choice_model.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';

class AnswerWidget extends GetView<QuizController> {
  const AnswerWidget({super.key, required this.choice});

  final ChoiceModel choice;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                hoverColor: kprimaryBlueColor,
                activeColor: kprimaryBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Colors.blue),
                ),
                value: controller.userSolutions.containsKey(choice.questionId!) &&
                    controller.userSolutions.containsValue(choice.id!),
                onChanged: (value) {
                  controller.provideSolution(choice.questionId!, choice.id!);
                },
              ),
            ),
            Column(
              children: [
                if (choice.image != null)
                  CachedImageWithFallback(
                    imageFound: choice.imageExist!,
                    imageUrl: choice.image!,
                    height: 200.h,
                    width: 260.w,
                  ),
                SizedBox(
                  width: 280.w,
                  child: Text(choice.title ?? ""),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
