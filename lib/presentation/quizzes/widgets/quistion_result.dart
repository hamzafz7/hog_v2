import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/question_model.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:hog_v2/presentation/quizzes/widgets/explaination_widget.dart';
import 'package:hog_v2/presentation/quizzes/widgets/result_list_tile.dart';

class QuestionResultWidget extends GetView<QuizController> {
  const QuestionResultWidget(
      {super.key, required this.index, required this.isTrue, required this.model});

  final int index;

  final bool isTrue;
  final QuestionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 360.w,
              decoration: BoxDecoration(
                  border: Border.all(color: isTrue ? Colors.green : Colors.red),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1, spreadRadius: 1, color: Color.fromARGB(255, 231, 231, 231))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "السؤال ${index + 1}:",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      model.title ?? "هذا السؤال بلا نص",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: kprimaryGreyColor),
                    ),
                    if (model.image != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedImageWithFallback(
                          imageFound: model.imageExist!,
                          imageUrl: model.image!,
                          height: 136.h,
                          width: 166.w,
                          fit: BoxFit.cover,
                        ),
                      )
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.choices!.length,
              itemBuilder: (context, index) => ResultListTile(
                userSolution: controller.userSolutions.containsValue(model.choices![index].id),
                choiceModel: model.choices![index],
                value:
                    // controller.userSolutions
                    //         .containsValue(model.choices![index].id) &&
                    controller.rightSolutions.containsValue(model.choices![index].id),
              ),
            ),
            if (model.clarificationImage != null || model.clarificationText != null)
              ExplainationWidget(
                imageExist: model.clarificationImageExist,
                image: model.clarificationImage,
                text: model.clarificationText,
              )
          ],
        ),
      ),
    );
  }
}
