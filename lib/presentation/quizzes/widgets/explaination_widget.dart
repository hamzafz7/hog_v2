import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';

class ExplainationWidget extends StatelessWidget {
  const ExplainationWidget({super.key, this.image, this.text, this.imageExist});

  final String? image;
  final bool? imageExist;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("التوضيح :"),
          if (image != null)
            CachedImageWithFallback(
              imageFound: imageExist!,
              imageUrl: image!,
              height: 200.h,
              width: 260.w,
            ),
          SizedBox(
            width: 280.w,
            child: Text(text ?? ""),
          ),
        ],
      ),
    );
  }
}
