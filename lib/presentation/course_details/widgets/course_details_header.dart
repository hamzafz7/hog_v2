import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/presentation/course_details/widgets/cached_image_with_fallback.dart';

class CourseDetailsHeader extends StatelessWidget {
  const CourseDetailsHeader({super.key, this.image, this.text, this.imageExist});

  final String? image;
  final bool? imageExist;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("image $image");
    }
    return SizedBox(
      height: 337.h,
      width: Get.width,
      child: Stack(
        children: [
          CachedImageWithFallback(
            imageUrl: image ?? defPic,
            height: Get.height * 0.4,
            width: Get.width,
          ),
          SizedBox(
            width: Get.width,
            height: Get.height * 0.4,
            child: Image.asset(
              "assets/images/grey_pic.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: 120.h,
            bottom: 0,
            left: 10.w,
            right: 10.w,
            child: SizedBox(
              width: 300.w,
              child: Text(
                text ?? "لا يوجد اسم لهذا الكورس",
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 36.sp),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
