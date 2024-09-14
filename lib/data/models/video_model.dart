class Video {
  final String courseName;
  final String videoName;
  final String key;
  final String? description;
  final int id;

  Video(
      {required this.courseName,
      required this.videoName,
      required this.key,
      required this.description,
      required this.id});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
        courseName: map['courseName'],
        videoName: map['videoName'],
        key: map['encryptedKey'],
        description: map['description'],
        id: map['videoId']);
  }
}
