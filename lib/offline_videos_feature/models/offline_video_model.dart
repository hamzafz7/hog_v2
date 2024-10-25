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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lessonTitle': lessonTitle,
      'video_id': videoId,
      'materialTeacherName': materialTeacherName,
      'materialName': materialName,
    };
  }

  static String encode(List<OfflineVideoModel> videos) => json.encode(
        videos.map<Map<String, dynamic>>((video) => video.toMap()).toList(),
      );

  static List<OfflineVideoModel> decode(String videos) => (json.decode(videos) as List<dynamic>)
      .map<OfflineVideoModel>((item) => OfflineVideoModel.fromJson(item))
      .toList();
}
