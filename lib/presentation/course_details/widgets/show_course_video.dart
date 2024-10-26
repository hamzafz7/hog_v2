import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/presentation/course_details/controller/show_lesson_controller.dart';
import 'package:pod_player/pod_player.dart';

class ShowCourseVideo extends StatefulWidget {
  const ShowCourseVideo({super.key, this.description, this.name});

  final String? description;
  final String? name;

  @override
  State<ShowCourseVideo> createState() => _ShowCourseVideoState();
}

class _ShowCourseVideoState extends State<ShowCourseVideo> {
  late ShowLessonController showLessonController;

  @override
  void initState() {
    super.initState();
    showLessonController = Get.find<ShowLessonController>();

    // Initialize video if necessary in initState or on page load.
    // Example: showLessonController.watchVideo(Get.arguments["link"]);
  }

  @override
  void dispose() {
    // Dispose PodPlayerController manually here when the widget is disposed
    showLessonController.podPlayerController?.dispose();
    showLessonController.podPlayerController = null; // Ensure it's cleared out
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ShowLessonController>(
          builder: (_) {
            if (showLessonController.watchVideoStatus == RequestStatus.success) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: showLessonController.podPlayerController != null
                          ? PodVideoPlayer(
                              controller: showLessonController.podPlayerController!,
                              podProgressBarConfig: const PodProgressBarConfig(
                                playingBarColor: Colors.red,
                                bufferedBarColor: Colors.grey,
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: Text(
                        "اسم الفيديو :",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                      child: Text(Get.arguments["name"]!),
                    ),
                    if (widget.description != null && widget.description!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: Text(
                          "الوصف الخاص في هذا الدرس:",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                        ),
                      ),
                    if (Get.arguments["description"] != null &&
                        Get.arguments["description"]!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                        child: Text(Get.arguments["description"]!),
                      ),
                  ],
                ),
              );
            } else if (showLessonController.watchVideoStatus == RequestStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("حدث خطأ ما أثناء تحميل الفيديو"));
            }
          },
        ),
      ),
    );
  }
}
