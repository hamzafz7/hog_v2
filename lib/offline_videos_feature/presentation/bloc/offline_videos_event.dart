import 'package:hog_v2/data/models/video_model.dart';

import '../../../data/models/courses_model.dart';

abstract class OfflineVideosEvent {}

class GetOfflineVideos extends OfflineVideosEvent {}

class GetOfflineDocuments extends OfflineVideosEvent {}

class GetVideosMaterials extends OfflineVideosEvent {}

class PlayOfflineVideo extends OfflineVideosEvent {}

class DeleteOfflineVideo extends OfflineVideosEvent {
  final int index;
  final int videoId;
  final bool fromFilter;

  DeleteOfflineVideo(this.index, {required this.fromFilter, required this.videoId});
}

class SelectVideoMaterial extends OfflineVideosEvent {
  final String material;

  SelectVideoMaterial(this.material);
}

class AddVideoToLocalStorage extends OfflineVideosEvent {
  final int videoId;
  final int lessonId;
  final String ytVideoTitle;
  final String lessonTitle;
  final String sectionTeacherName;
  final String sectionName;

  AddVideoToLocalStorage(
      {required this.videoId,
      required this.lessonId,
      required this.sectionName,
      required this.sectionTeacherName,
      required this.ytVideoTitle,
      required this.lessonTitle});
}

class InitializeOfflineVideo extends OfflineVideosEvent {
  final int videoId;

  InitializeOfflineVideo(this.videoId);
}

class DisposeVideoController extends OfflineVideosEvent {}

class IncreaseIncrement extends OfflineVideosEvent {}

class DownloadYoutubeVideo extends OfflineVideosEvent {
  final Video videoModel;
  final String sectionName;
  final String courseName;
  final String tilteVideo;
  final String link;

  DownloadYoutubeVideo(
      {required this.videoModel,
      required this.tilteVideo,
      required this.courseName,
      required this.link,
      required this.sectionName});
}

class GetVideoMeta extends OfflineVideosEvent {
  final Video videoModel;

  GetVideoMeta(this.videoModel);
}

class StartDownloadVideo extends OfflineVideosEvent {
  final Video videoModel;

  StartDownloadVideo(this.videoModel);
}

class CancelDownload extends OfflineVideosEvent {
  final Video videoModel;

  CancelDownload(this.videoModel);
}

class RemoveVideoFromCustomList extends OfflineVideosEvent {
  final int videoId;

  RemoveVideoFromCustomList(this.videoId);
}

class UpdateVideosCount extends OfflineVideosEvent {}

class ClearDownloadingData extends OfflineVideosEvent {}

class ClearDispose extends OfflineVideosEvent {}

class InitializeCurrentCourse extends OfflineVideosEvent {
  final CourseModel courseModel;

  InitializeCurrentCourse(this.courseModel);
}
