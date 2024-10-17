import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/download_model.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog_v2/presentation/widgets/quality_button.dart';

// ignore: must_be_immutable
class PickQualityDialog extends StatelessWidget {
  PickQualityDialog({
    super.key,
    required this.response,
    required this.videoName,
    required this.courseName,
    required this.description,
    required this.videoId,
    required this.onRealDownload,
  });

  final DownloadResponse response;
  final String videoName;
  final String? description;
  final int videoId;
  final String courseName;
  final controller = Get.find<CourseDetailsController>();
  Function(String) onRealDownload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            "اختر الدقة المناسبة:",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kDarkBlueColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: response.downloadOptions.length,
              itemBuilder: (item, index) => QualityButton(
                  onPressed: () {
                    onRealDownload(response.downloadOptions[index].link!);
                    // controller.saveAndDownload(
                    //     url: response.downloadOptions[index].link!,
                    //     courseName: courseName,
                    //     courseVidName: videoName,
                    //     videoId: videoId,
                    //     description: description);
                    Get.back();
                  },
                  quality: response.downloadOptions[index].quality!)),
        ),
      ]),
    );
  }
}
