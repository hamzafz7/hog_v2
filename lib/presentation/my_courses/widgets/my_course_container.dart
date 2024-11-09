import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/models/courses_model.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';
import 'package:svg_flutter/svg_flutter.dart';

class MyCourseCotainer extends StatelessWidget {
  const MyCourseCotainer({super.key, required this.courseModel});

  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.downloadedVideosRoute, arguments: courseModel);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
        child: Container(
          width: 372.w,
          height: 123.h,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: Colors.black.withOpacity(0.10000000149011612),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedImageWithFallback(
                    imageUrl: courseModel.image ?? defPic,
                    height: 105.h,
                    width: 114.w,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl: courseModel.image ?? defPic,
                  //   height: 105.h,
                  //   width: 114.w,
                  //   fit: BoxFit.fill,
                  //   progressIndicatorBuilder: (___, __, _) => ShimmerPlaceholder(
                  //     child: Container(
                  //       height: 105.h,
                  //       width: 114.w,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   errorWidget: (context, url, error) => const Icon(Icons.error),
                  // ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        courseModel.name ?? "لا يوجد اسم",
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyMedium!,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/icons/users.svg"),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                          width: 95.w,
                          child: Wrap(
                            children: List.generate(
                                courseModel.teachers!.length > 3 ? 3 : courseModel.teachers!.length,
                                (index) => Text(
                                      courseModel.teachers![index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 10.sp, color: kprimaryGreyColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                          ))
                    ],
                  )
                ],
              ),
              // Center(
              //   child: SizedBox(
              //     width: 30.w,
              //     child: CircularPercentIndicator(
              //       radius: 30.0,
              //       lineWidth: 5.0,
              //       percent: 0.6,
              //       center: Text(
              //         "${60}%",
              //         style: Theme.of(context).textTheme.bodySmall,
              //       ),
              //       progressColor: kprimaryBlueColor,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
