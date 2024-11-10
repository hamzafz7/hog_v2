import 'package:flutter/foundation.dart';
// import "dart:io";

import 'package:get/get.dart';
import "package:hog_v2/common/constants/enums/request_enum.dart";
// import 'package:http/http.dart' as http;
// import "package:path_provider/path_provider.dart";
import 'package:pod_player/pod_player.dart';

class ShowLessonController extends GetxController {
  // final CategoryRepository _categoryRepository = CategoryRepository();
  PodPlayerController? podPlayerController;
  var watchVideoStatus = RequestStatus.begin;

  updateWatchVideoStatus(RequestStatus status) => watchVideoStatus = status;

  @override
  void onInit() {
    String link = Get.arguments["link"];
    watchVideo(link);
    super.onInit();
  }

  /// Load and initialize video from a URL
  Future<void> watchVideo(String link) async {
    updateWatchVideoStatus(RequestStatus.loading);
    update();
    try {
      podPlayerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(link),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
        ),
      );
      await podPlayerController?.initialise();
      updateWatchVideoStatus(RequestStatus.success);
    } catch (e) {
      updateWatchVideoStatus(RequestStatus.onError);
    }
    update();
  }

  /// Ensure PodPlayerController is disposed of
  void disposePodPlayerController() {
    if (kDebugMode) {
      print("-------------------------------");
    }
    if (podPlayerController != null) {
      podPlayerController?.dispose();
      podPlayerController = null;

      if (kDebugMode) {
        print("PodPlayerController has been disposed.");
      }
    } else {
      if (kDebugMode) {
        print("PodPlayerController was already disposed or null.");
      }
    }
  }

  @override
  void onClose() {
    disposePodPlayerController();
    Get.delete<ShowLessonController>(force: true);
    super.onClose();
  }
}
