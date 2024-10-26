import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/models/video_link_response.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog_v2/presentation/widgets/quality_button.dart';

class PickQualityFromUrl extends StatelessWidget {
  PickQualityFromUrl(
      {super.key, required this.response, this.description, required this.id, required this.name});
  final VideoLinksResponse response;
  final String? description;
  final String name;

  final int id;
  final controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            "اختر الدقة المناسبة:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kDarkBlueColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: response.link.length,
              itemBuilder: (item, index) => QualityButton(
                  onPressed: () {
                    Get.back();
                    if (kDebugMode) {
                      print(response.link[index].link);
                    }
                    Get.toNamed(
                      AppRoute.showCourseVideoRoute,
                      arguments: {
                        "link": response.link[index].link,
                        "name": name,
                        "description": description
                      },
                    );
                    controller.isWatched(id);
                  },
                  quality: response.link[index].rendition)),
        ),
      ]),
    );
  }
}
