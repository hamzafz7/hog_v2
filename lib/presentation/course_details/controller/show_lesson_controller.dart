import 'package:get/get.dart';
import "package:hog_v2/common/constants/enums/request_enum.dart";
import "package:hog_v2/data/repositories/category_repo.dart";
import 'package:pod_player/pod_player.dart';

class ShowLessonController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();
  PodPlayerController? podPlayerController;
  var watchVideoStatus = RequestStatus.begin.obs;

  updateWatchVideoStatus(RequestStatus status) => watchVideoStatus.value = status;

  @override
  void onInit() {
    String link = Get.arguments["link"];
    watchVideo(link);
    super.onInit();
  }

  /// Load and initialize video from a URL
  Future<void> watchVideo(String link) async {
    updateWatchVideoStatus(RequestStatus.loading);
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
  }

  /// Ensure PodPlayerController is disposed of
  void disposePodPlayerController() {
    print("-------------------------------");
    if (podPlayerController != null) {
      podPlayerController?.dispose();
      podPlayerController = null;

      print("PodPlayerController has been disposed.");
    } else {
      print("PodPlayerController was already disposed or null.");
    }
  }

  @override
  void onClose() {
    disposePodPlayerController();
    Get.delete<ShowLessonController>(force: true);
    watchVideoStatus.close();
    super.onClose();
  }
}
