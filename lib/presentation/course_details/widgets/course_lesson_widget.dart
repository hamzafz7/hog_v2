import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog/common/constants/colors.dart';
import 'package:hog/common/constants/enums/request_enum.dart';
import 'package:hog/data/models/lession_model.dart';
import 'package:hog/data/models/video_model.dart';
import 'package:hog/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog/presentation/course_details/widgets/course_pdf.dart';
import 'package:hog/presentation/custom_dialogs/complete_failure.dart';
import 'package:hog/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../offline_videos_feature/presentation/bloc/offline_videos_bloc.dart';
import '../../../offline_videos_feature/presentation/bloc/offline_videos_event.dart';
import '../../../offline_videos_feature/presentation/bloc/offline_videos_state.dart';
import '../../../offline_videos_feature/presentation/controllers/video_downloader.dart';

class CourseLessonWidget extends StatelessWidget {
  CourseLessonWidget({super.key, required this.lessionModel});

  final LessionModel lessionModel;
  final controller = Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (lessionModel.isOpen! ||
                    controller.courseInfoModel!.course!.isPaid! ||
                    controller.courseInfoModel!.course!.isOpen! ||
                    controller.courseInfoModel!.course!.isTeachWithCourse ==
                        true ||
                    CacheProvider.getUserType() == 'admin') {
                  if (lessionModel.type == 'video') {
                    controller.watchResponseFromUrl(context,
                        link: lessionModel.link!,
                        id: lessionModel.id,
                        description: lessionModel.description,
                        name: lessionModel.title ?? "لا يوجد اسم");
                  } else {
                    Get.to(FileViewWidget(imagePath: lessionModel.link!));
                    // print(lessionModel.link);
                  }
                } else {
                  CustomDialog(context, child: const CompleteFailureWidget());
                }
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: lessionModel.type == 'video'
                        ? lessionModel.isWatched == false
                            ? SvgPicture.asset(
                                'assets/icons/play-circle.svg',
                              )
                            : Container(
                                height: 26.h,
                                width: 26.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Icon(
                                  Icons.check,
                                  color:
                                      const Color.fromARGB(255, 207, 197, 197),
                                ),
                              )
                        : const Icon(
                            Icons.file_copy,
                            color: kprimaryBlueColor,
                          ),
                  ),
                  SizedBox(
                      width: 210.w,
                      child: Text(
                        lessionModel.title ?? " ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Spacer(),
            if (lessionModel.type == 'video' &&
                !controller.isVideoDownloaded(lessionModel.title ?? "none"))
              Obx(
                () => controller.downloadStatus.value ==
                            RequestStatus.loading &&
                        controller.currentDownloadedVidId
                            .contains(lessionModel.id)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 70.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 140, 186, 224)
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10.w)),
                          child: Center(
                            child: Text(
                              "جاري التحميل ..",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: kprimaryBlueColor,
                                      fontSize: 10.sp),
                            ),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          controller.updateCurrentId(lessionModel.id);
                          controller.downloadVideo(
                              lessionModel.link!,
                              context,
                              controller.courseInfoModel!.course!.name!,
                              lessionModel.title!,
                              lessionModel.id,
                              lessionModel.description, onRealDownload: (link) {
                            BlocProvider.of<OfflineVideosBloc>(context)
                                .add(DownloadYoutubeVideo(
                              sectionName: lessionModel.title!,
                              courseName:
                                  controller.courseInfoModel!.course!.name!,
                              videoModel: Video(
                                  courseName:
                                      controller.courseInfoModel!.course!.name!,
                                  videoName: lessionModel.title!,
                                  key: '',
                                  description: '',
                                  id: lessionModel.id),
                              tilteVideo: lessionModel.title!,
                              link: link,
                            ));
                          });

                          // if ((lessionModel.isOpen! ||
                          //         controller.courseInfoModel!.course!.isPaid! ||
                          //         controller.courseInfoModel!.course!.isOpen! ||
                          //         controller.courseInfoModel!.course!
                          //                 .isTeachWithCourse ==
                          //             true ||
                          //         CacheProvider.getUserType() == 'admin') &&
                          //     controller.downloadStatus.value !=
                          //         RequestStatus.loading) {
                          //   controller.updateCurrentId(lessionModel.id);
                          //   controller.downloadVideo(
                          //       lessionModel.link!,
                          //       context,
                          //       controller.courseInfoModel!.course!.name!,
                          //       lessionModel.title!,
                          //       lessionModel.id,
                          //       lessionModel.description);
                          // }
                        },
                        icon: Icon(
                          Icons.download,
                          color: kprimaryBlueColor,
                        )),
              )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        getDownloadingWidget(() {
          BlocProvider.of<OfflineVideosBloc>(context).add(CancelDownload(
            Video(
                courseName: controller.courseInfoModel!.course!.name!,
                videoName: lessionModel.title!,
                key: '',
                description: '',
                id: lessionModel.id),
          ));
        }, context, lessionModel.id)
      ],
    );
  }

  Widget getDownloadingWidget(
      Function onCancelDownload, BuildContext context, int videoId) {
    return BlocBuilder(
      bloc: BlocProvider.of<OfflineVideosBloc>(context),
      builder: (BuildContext context, OfflineVideosState state) {
        // log("------> Start Downloading...");
        log(state.customVideosDownloading.length.toString());
        if (state.customVideosDownloading
            .where((element) => element.videoModel.id == videoId)
            .isEmpty) {
          return Container();
        } else if (state.customVideosDownloading
                .where((element) => element.videoModel.id == videoId)
                .isNotEmpty &&
            state.customVideosDownloading
                .where((element) => element.videoModel.id == videoId)
                .first
                .isFetchingAPI) {
          return downloadingWidget(
              onCancelDownload: () => onCancelDownload(),
              value: "",
              percent: null);
        } else {
          log(state.customVideosDownloading
              .where((element) => element.videoModel.id == videoId)
              .first
              .videoDownloader
              .newDownloadPercentage
              .toString());
          return ValueListenableBuilder(
            valueListenable: state.customVideosDownloading
                .where((element) => element.videoModel.id == videoId)
                .first
                .videoDownloader
                .downloadStatus,
            builder: (context, value, _) {
              return value == DownloadStatus.downloading
                  ? ValueListenableBuilder(
                      valueListenable: state.customVideosDownloading
                          .where((element) => element.videoModel.id == videoId)
                          .first
                          .videoDownloader
                          .newDownloadPercentage,
                      builder: (BuildContext context,
                          Map<String, dynamic> value, Widget? child) {
                        return downloadingWidget(
                            onCancelDownload: () => onCancelDownload(),
                            value: value["value"],
                            percent: value["percent"] / 100);
                      },
                    )
                  : Container();
            },
          );
        }
      },
    );
  }

  Widget downloadingWidget(
      {required Function onCancelDownload,
      required String value,
      required double? percent}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.5))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "جاري تحميل الفيديو",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.purple),
                    ),
                    GestureDetector(
                      onTap: () {
                        onCancelDownload();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    minHeight: 10.0,
                    value: percent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.orange, fontSize: 11.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
