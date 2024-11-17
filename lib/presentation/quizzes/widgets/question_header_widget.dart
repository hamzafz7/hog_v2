import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/course_details/widgets/cached_image_with_fallback.dart';
import 'package:hog_v2/presentation/quizzes/pages/quiz_image_full_screen.dart';

class QuestionHeaderWidget extends StatelessWidget {
  const QuestionHeaderWidget(
      {super.key, required this.index, this.title, this.image, this.imageExist});

  final int index;
  final String? title;
  final String? image;
  final bool? imageExist;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 360.w,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 1, spreadRadius: 1, color: Color.fromARGB(255, 231, 231, 231))
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
                title ?? "هذا السؤال بلا نص",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kprimaryGreyColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (image != null)
                InkWell(
                  onTap: () {
                    Get.to(() => QuizImageFullScreen(image: image!));
                  },
                  child: CachedImageWithFallback(
                    imageUrl: image!,
                    height: 200.h,
                    width: 260.w,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
