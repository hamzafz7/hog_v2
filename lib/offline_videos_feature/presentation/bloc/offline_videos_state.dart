import 'package:built_value/built_value.dart';
import 'package:pod_player/pod_player.dart';
import 'dart:async';

import '../../../data/models/courses_model.dart';
import '../../helpers/error/failures.dart';
import '../../models/custom_video_model.dart';
import '../../models/offline_video_model.dart';

part 'offline_videos_state.g.dart';

abstract class OfflineVideosState
    implements Built<OfflineVideosState, OfflineVideosStateBuilder> {
  OfflineVideosState._();

  factory OfflineVideosState([Function(OfflineVideosStateBuilder b) updates]) =
      _$OfflineVideosState;

  Failure? get failure;

  bool get isGettingVideos;
  bool get errorGettingVideos;
  bool get videosFetched;

  bool get isDownloadingVideo;
  bool get errorDownloadingVideo;
  bool get videoDownloaded;

  bool get isLoadingOfflineVideo;

  bool get isLoadingVideos;
  List<OfflineVideoModel> get offlineVideos;
  List<OfflineVideoModel> get filteredOfflineVideos;

  PodPlayerController? get podController;
  StreamController<double?> get percentageDataRead;

  bool get offlineVideoLoaded;

  bool get isLoadingOfflinePDFFile;

  bool get isLoadingMaterials;
  bool get offlineItemIsDeleted;
  List<String> get videosMaterials;

  String get selectedVideoMaterial;

  int get downloadingItemCount;

  List<int> get downloadingIds;

  List<CustomVideoModel> get customVideosDownloading;
  bool get newVideoAddedToDownload;
  bool get gotVideoMetaToDownload;
  bool get isGettingMetaData;
  bool get videoRemovedFromList;
  CourseModel? get currentCourse;

  factory OfflineVideosState.initial() {
    return OfflineVideosState((b) => b
      ..percentageDataRead = StreamController()
      ..selectedVideoMaterial = "All"
      ..downloadingIds = []
      ..offlineVideos = []
      ..customVideosDownloading = []
      ..filteredOfflineVideos = []
      ..videosMaterials = []
      ..isGettingMetaData = false
      ..videoRemovedFromList = false
      ..isLoadingMaterials = false
      ..newVideoAddedToDownload = false
      ..gotVideoMetaToDownload = false
      ..isGettingVideos = false
      ..offlineVideoLoaded = false
      ..isLoadingOfflineVideo = false
      ..errorGettingVideos = false
      ..videosFetched = false
      ..isDownloadingVideo = false
      ..isLoadingVideos = false
      ..errorDownloadingVideo = false
      ..videoDownloaded = false
      ..isLoadingOfflinePDFFile = false
      ..offlineItemIsDeleted = false
      ..downloadingItemCount = 0
    );
  }
}
