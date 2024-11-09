import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/models/course_info_model.dart';
import 'package:hog_v2/data/models/courses_model.dart';
import 'package:hog_v2/data/models/download_model.dart';
import 'package:hog_v2/data/models/video_link_response.dart';
import 'package:hog_v2/data/repositories/category_repo.dart';
import 'package:hog_v2/offline_videos_feature/helpers/prefs_helper.dart';
import 'package:hog_v2/offline_videos_feature/models/offline_video_model.dart';
import 'package:hog_v2/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:hog_v2/presentation/custom_dialogs/pick_quality_dialog.dart';
import 'package:hog_v2/presentation/custom_dialogs/pick_quality_from_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsController extends GetxController {
  @override
  void onClose() {
    activationController.dispose();
    _retryTimer?.cancel();
    super.onClose();
  }

  SharedPreferences? shared;
  PrefsHelper? _helper;
  List<OfflineVideoModel> offlines = [];
  List<int> videoIds = [];

  @override
  void onInit() {
    _courseModel = Get.arguments;
    getCourseInfo(_courseModel!.id).then((value) {});
    super.onInit();
    SharedPreferences.getInstance().then((value) {
      shared = value;
      _helper = PrefsHelper(shared!);

      getOfflineVideos().then((_) {
        for (var e in offlines) {
          videoIds.add(e.videoId);
        }
        if (kDebugMode) {
          print(videoIds);
        }
      });
    });
  }

  bool isLessionExist(int id) {
    for (int i = 0; i < videoIds.length; i++) {
      if (id == videoIds[i]) {
        return true;
      }
    }

    return false;
  }

  Future getOfflineVideos() async {
    offlines = await _helper!.fetchOfflineVideos();
  }

  int currentTabIndex = 0;

  void updateCurrentTabIndex(int index) {
    currentTabIndex = index;
    update();
  }

  int currentWidgetIndex = 0;

  changeCurrentWidgetIndex(int val) {
    currentWidgetIndex = val;
    update();
  }

  VideoLinksResponse? watchResponse;

  Future<void> watchResponseFromUrl(
    BuildContext context, {
    required String link,
    required int id,
    String? description,
    String? source,
    required String name,
  }) async {
    var response = await _categoryRepository.watchVideo(link, source ?? "");
    if (kDebugMode) {
      print(link);
    }

    if (response.success) {
      if (kDebugMode) {
        print("response : ${response.data}");
      }
      watchResponse = VideoLinksResponse.fromJson(response.data);
      customDialog(context,
          child: PickQualityFromUrl(
            response: watchResponse!,
            id: id,
            description: description,
            name: name,
          ));
    } else {
      if (kDebugMode) {
        print(response.errorMessage);
      }
    }
  }

  TextEditingController activationController = TextEditingController();
  var courseDetailFormKey = GlobalKey<FormState>();

  CourseModel? _courseModel;
  CourseInfoResponse? courseInfoModel;

  var getCourseInfoStatus = RequestStatus.begin;
  var signInCourseStatus = RequestStatus.begin;

  final CategoryRepository _categoryRepository = CategoryRepository();

  void updateGetCourseInfo(RequestStatus status) => getCourseInfoStatus = status;

  void updateSignInCourseStatus(RequestStatus status) => signInCourseStatus = status;

  Future<void> signInCourse(int id, String activationCode) async {
    updateSignInCourseStatus(RequestStatus.loading);
    update();
    _categoryRepository.signInCourse(id, activationCode).then((response) {
      if (response.success) {
        if (kDebugMode) {
          print(response.data);
        }
        updateSignInCourseStatus(RequestStatus.success);
        update();
        Get.back();
        getCourseInfo(id);
      } else {
        if (kDebugMode) {
          print(response.errorMessage);
        }
        updateSignInCourseStatus(RequestStatus.onError);
        update();
        Get.back();
        Get.snackbar("حدث خطأ", response.errorMessage!);
      }
    });
  }

  Future<void> getCourseInfo(int id) async {
    updateGetCourseInfo(RequestStatus.loading);
    update();
    _categoryRepository.getCourseInfo(id).then((response) {
      if (kDebugMode) {
        print("Response error message: ${response.errorMessage}");
      }
      if (response.success) {
        if (kDebugMode) {
          print(response.data);
        }
        courseInfoModel = CourseInfoResponse.fromJson(response.data);
        GetIt.instance<Utils>().logPrint(response.data);
        if (courseInfoModel == null || courseInfoModel!.course == null) {
          updateGetCourseInfo(RequestStatus.noData);
        } else {
          if (kDebugMode) {
            print(
                'courseInfoModel!.course!.image in CourseDetailsPage-------------------- ${courseInfoModel!.course!.image}');
            print(courseInfoModel!.course!.image);
          }
          updateGetCourseInfo(RequestStatus.success);
        }
      } else {
        if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
          updateGetCourseInfo(RequestStatus.noInternentt);
        } else {
          updateGetCourseInfo(RequestStatus.onError);
        }
      }
      update();
    });
  }

  void launchTelegramURL(String? url) async {
    if (url != null) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  DownloadResponse? downloadResponse;
  var downloadStatus = RequestStatus.begin;

  void updateDownloadStatus(RequestStatus status) => downloadStatus = status;

  List<int> currentDownloadedVidId = <int>[];

  void updateCurrentId(int id) {
    currentDownloadedVidId.add(id);
  }

  Future<void> isWatched(int lessonId) async {
    var response = await _categoryRepository.isWatched(lessonId);
    if (kDebugMode) {
      print(response.success);
    }
  }

  // Download-related fields
  // RxBool isDownloading = false.obs;
  // RxInt downloaded = 0.obs;
  // RxInt fileLength = 0.obs;
  // RxBool isPaused = false.obs;
  // RxBool isReconnecting = false.obs;
  // StreamSubscription<List<int>>? _downloadSubscription;
  Timer? _retryTimer;

  Future<void> downloadVideo(String link, BuildContext context, String courseName, String videoName,
      int videoId, String? description, String source,
      {required Function(String) onRealDownload}) async {
    updateDownloadStatus(RequestStatus.loading);
    update();
    var response = await _categoryRepository.downloadVideo(link, source);
    if (response.success) {
      downloadResponse = DownloadResponse.fromJson(response.data["data"]['link']);
      if (kDebugMode) {
        print("course video :$videoName");
      }

      customDialog(
        context,
        child: PickQualityDialog(
          response: downloadResponse!,
          onRealDownload: onRealDownload,
          videoName: videoName,
          courseName: courseName,
          videoId: videoId,
          description: description,
        ),
      );

      updateDownloadStatus(RequestStatus.success);
    } else {
      // Handle error if the response is unsuccessful
      updateDownloadStatus(RequestStatus.onError);
    }
    update();
  }
}
