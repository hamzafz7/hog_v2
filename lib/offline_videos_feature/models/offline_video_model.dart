import 'dart:convert';

class OfflineVideoModel {
  final String materialName;
  final String materialTeacherName;
  final String title;
  final int videoId;
  final String? lessonTitle;
  bool isDeleting = false;

  OfflineVideoModel({
    required this.title,
    required this.lessonTitle,
    required this.materialName,
    required this.materialTeacherName,
    required this.videoId,
  });

  factory OfflineVideoModel.fromJson(Map<String, dynamic> json) {
    return OfflineVideoModel(
      title: json['title'],
      lessonTitle: json['lessonTitle'],
      materialTeacherName: json['materialTeacherName'],
      materialName: json['materialName'],
      videoId: json['video_id'],
    );
  }

  static Map<String, dynamic> toMap(OfflineVideoModel offlineVideoModel) {
    return {
      'title': offlineVideoModel.title,
      'lessonTitle': offlineVideoModel.lessonTitle,
      'video_id': offlineVideoModel.videoId,
      'materialTeacherName': offlineVideoModel.materialTeacherName,
      'materialName': offlineVideoModel.materialName,
    };
  }

  static String encode(List<OfflineVideoModel> videos) => json.encode(
        videos
            .map<Map<String, dynamic>>(
                (video) => OfflineVideoModel.toMap(video))
            .toList(),
      );

  static List<OfflineVideoModel> decode(String videos) =>
      (json.decode(videos) as List<dynamic>)
          .map<OfflineVideoModel>((item) => OfflineVideoModel.fromJson(item))
          .toList();
}
