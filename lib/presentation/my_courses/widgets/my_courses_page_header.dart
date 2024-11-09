import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/endpoints.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';

class MyCoursesPageHeader extends StatelessWidget {
  const MyCoursesPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مرحبا ',
                  style:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(color: kprimaryGreyColor)),
              Text(GetIt.instance<CacheProvider>().getUserName() ?? "UnKnown",
                  style: Theme.of(context).textTheme.bodyLarge!)
            ],
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(border: Border.all(color: kprimaryBlueColor)),
              child: CachedImageWithFallback(
                /// TODO: when use it sure about it
                imageUrl: GetIt.instance<CacheProvider>().getUserImage() != null
                    ? imagebaseUrl + GetIt.instance<CacheProvider>().getUserImage()
                    : "https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1702746365~exp=1702746965~hmac=d69d2e417b17c8e24a04eabd7a5d0ca923eb3a5806a83f576d1f19f0da10318f",
                height: 50.h,
                width: 50.w,
              ),
              // CachedNetworkImage(
              //   imageUrl: GetIt.instance<CacheProvider>().getUserImage() != null
              //       ? imagebaseUrl + GetIt.instance<CacheProvider>().getUserImage()
              //       : "https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1702746365~exp=1702746965~hmac=d69d2e417b17c8e24a04eabd7a5d0ca923eb3a5806a83f576d1f19f0da10318f",
              //   height: 50.h,
              //   width: 50.w,
              //   fit: BoxFit.fill,
              //   progressIndicatorBuilder: (___, __, _) => ShimmerPlaceholder(
              //     child: Container(
              //       height: 50.h,
              //       width: 50.w,
              //       color: Colors.black,
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
