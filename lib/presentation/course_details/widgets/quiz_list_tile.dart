// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/models/quiz_model.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog_v2/presentation/custom_dialogs/complete_failure.dart';
import 'package:hog_v2/presentation/custom_dialogs/custom_dialogs.dart';

class QuizListTile extends GetView<CourseDetailsController> {
  const QuizListTile({super.key, required this.quizzModel});
  final QuizzModel quizzModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
              width: 250.w,
              child: Text(
                quizzModel.title ?? " ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          GestureDetector(
            onTap: () {
              print(quizzModel.description);
              if (quizzModel.isFree == 1 ||
                  GetIt.instance<CacheProvider>().getUserType() == 'admin' ||
                  controller.courseInfoModel!.course!.isOpen == true ||
                  controller.courseInfoModel!.course!.isPaid == true) {
                Get.toNamed(AppRoute.quizzPageRoute, arguments: quizzModel);
              } else {
                customDialog(context, child: const CompleteFailureWidget());
              }
            },
            child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Text(
                  "بدء",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
                )),
          ),
        ],
      ),
    );
  }
}
