import 'package:hog_v2/data/models/video_model.dart';

import '../presentation/controllers/video_downloader.dart';

class CustomVideoModel {
  final Video videoModel;
  final VideoDownloader videoDownloader = VideoDownloader();
  bool isFetchingAPI = false;
  bool isDownloading = false;
  String downloadPercent = "";

  CustomVideoModel({required this.videoModel});
}
