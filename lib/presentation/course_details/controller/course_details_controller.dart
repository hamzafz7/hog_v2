import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog/offline_videos_feature/helpers/prefs_helper.dart';
import 'package:hog/offline_videos_feature/helpers/shared_keys.dart';
import 'package:hog/offline_videos_feature/models/offline_video_model.dart';
import 'package:hog/presentation/custom_dialogs/pick_quality_dialog.dart';
import 'package:hog/common/constants/enums/request_enum.dart';
import 'package:hog/common/utils/utils.dart';
import 'package:hog/data/models/course_info_model.dart';
import 'package:hog/data/models/courses_model.dart';
import 'package:hog/data/models/download_model.dart';
import 'package:hog/data/models/video_link_response.dart';
import 'package:hog/data/repositories/category_repo.dart';
import 'package:hog/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:hog/presentation/custom_dialogs/pick_quality_from_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsController extends GetxController {
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
        offlines.forEach((e) {
          videoIds.add(e.videoId);
        });
        print(videoIds);
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

  RxInt currentTabIndex = 0.obs;

  void updateCurrentTabIndex(int index) {
    currentTabIndex.value = index;
  }

  RxInt currentWidgetIndex = 0.obs;

  changeCurrentWidgetIndx(int val) {
    currentWidgetIndex.value = val;
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
    print(link);

    if (response.success) {
      print("response : ${response.data}");
      watchResponse = VideoLinksResponse.fromJson(response.data);
      CustomDialog(context,
          child: PickQualityFromUrl(
            response: watchResponse!,
            id: id,
            description: description,
            name: name,
          ));
    } else {
      print(response.errorMessage);
    }
  }

  TextEditingController activationController = TextEditingController();
  var courseDetailFormKey = GlobalKey<FormState>();

  CourseModel? _courseModel;
  CourseInfoResponse? courseInfoModel;

  var getCourseInfoStatus = RequestStatus.begin.obs;
  var signInCourseStatus = RequestStatus.begin.obs;

  final CategoryRepository _categoryRepository = CategoryRepository();

  void updateGetCourseInfo(RequestStatus status) =>
      getCourseInfoStatus.value = status;

  void updateSignInCourseStatus(RequestStatus status) =>
      signInCourseStatus.value = status;

  Future<void> signInCourse(int id, String activationCode) async {
    updateSignInCourseStatus(RequestStatus.loading);
    var response = await _categoryRepository.signInCourse(id, activationCode);
    if (response.success) {
      print(response.data);
      updateSignInCourseStatus(RequestStatus.success);
      Get.back();
      getCourseInfo(id);
    } else {
      print(response.errorMessage);
      Get.back();
      Get.snackbar("حدث خطأ", response.errorMessage!);
      updateSignInCourseStatus(RequestStatus.onError);
    }
  }

  Future<void> getCourseInfo(int id) async {
    updateGetCourseInfo(RequestStatus.loading);
    var response = await _categoryRepository.getCourseInfo(id);
    print("Response error message: ${response.errorMessage}");
    if (response.success) {
      print(response.data);
      courseInfoModel = CourseInfoResponse.fromJson(response.data);
      Utils.logPrint(response.data);
      if (courseInfoModel == null || courseInfoModel!.course == null) {
        updateGetCourseInfo(RequestStatus.noData);
      } else {
        updateGetCourseInfo(RequestStatus.success);
      }
    } else {
      if (response.errorMessage == "لا يوجد اتصال بالانترنت") {
        updateGetCourseInfo(RequestStatus.noInternentt);
      } else {
        updateGetCourseInfo(RequestStatus.onError);
      }
    }
  }

  void changeCurrentWidgetIndex(int val) {
    currentWidgetIndex.value = val;
  }

  void launchTelegramURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  DownloadResponse? downloadResponse;
  var downloadStatus = RequestStatus.begin.obs;

  void updateDownloadStatus(RequestStatus status) =>
      downloadStatus.value = status;

  RxList<int> currentDownloadedVidId = <int>[].obs;

  void updateCurrentId(int id) {
    currentDownloadedVidId.add(id);
  }

  Future<void> isWatched(int lessonId) async {
    var response = await _categoryRepository.isWatched(lessonId);
    print(response.success);
  }

  // Download-related fields
  RxBool isDownloading = false.obs;
  RxInt downloaded = 0.obs;
  RxInt fileLength = 0.obs;
  RxBool isPaused = false.obs;
  RxBool isReconnecting = false.obs;
  StreamSubscription<List<int>>? _downloadSubscription;
  Timer? _retryTimer;

  Future<void> downloadVideo(
      String link,
      BuildContext context,
      String courseName,
      String videoName,
      int videoId,
      String? description,
      String source,
      {required Function(String) onRealDownload}) async {
    updateDownloadStatus(RequestStatus.loading);

    var response = await _categoryRepository.downloadVideo(link, source);
    if (response.success) {
      downloadResponse =
          DownloadResponse.fromJson(response.data["data"]['link']);
      print("course video :$videoName");

      CustomDialog(
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
  }

  // Cleanup on disposal
  @override
  void onClose() {
    _downloadSubscription?.cancel();
    _retryTimer?.cancel();
    super.onClose();
  }
}
