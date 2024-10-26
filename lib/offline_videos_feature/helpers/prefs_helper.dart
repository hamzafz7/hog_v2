import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hog_v2/offline_videos_feature/helpers/shared_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/offline_video_model.dart';

@LazySingleton()
class PrefsHelper extends ChangeNotifier {
  final SharedPreferences prefs;

  PrefsHelper(this.prefs);

  Future<List<String>> getVideosMaterials() async {
    final String? videosStr = prefs.getString(SharedPreferencesKeys.offlineVideos);
    if (videosStr == null) {
      return [];
    } else {
      final List<OfflineVideoModel> videos = OfflineVideoModel.decode(videosStr);
      List<String> materials = [];
      for (var item in videos) {
        if (!materials.contains(item.materialName)) {
          materials.add(item.materialName);
        }
      }
      return materials;
    }
  }

  Future<List<OfflineVideoModel>> fetchOfflineVideos() async {
    final String? videosStr = prefs.getString(SharedPreferencesKeys.offlineVideos);
    if (videosStr == null) {
      return [];
    } else {
      final List<OfflineVideoModel> videos = OfflineVideoModel.decode(videosStr);
      return videos;
    }
  }

  void storeNewVideo({required OfflineVideoModel offlineVideoModel}) async {
    List<OfflineVideoModel> videos = await fetchOfflineVideos();
    videos.add(offlineVideoModel);
    final String encodedData = OfflineVideoModel.encode(videos);
    await prefs.setString(SharedPreferencesKeys.offlineVideos, encodedData);
  }

  List<int> getStoredVideosIds() {
    List<String> mList = (prefs.getStringList(SharedPreferencesKeys.offlineVideosIds) ?? []);
    return mList.map((i) => int.parse(i)).toList();
  }

  Future<void> deleteVideoFromShared(int videoId) async {
    List<int> videosIds = getStoredVideosIds();
    if (videosIds.contains(videoId)) {
      videosIds.remove(videoId);
    }
    List<String> stringsList = videosIds.map((i) => i.toString()).toList();
    prefs.setStringList(SharedPreferencesKeys.offlineVideosIds, stringsList);
    List<OfflineVideoModel> videos = await fetchOfflineVideos();
    OfflineVideoModel offlineVideoModel =
        videos.where((element) => element.videoId == videoId).toList()[0];
    videos.remove(offlineVideoModel);
    final String encodedData = OfflineVideoModel.encode(videos);
    await prefs.setString(SharedPreferencesKeys.offlineVideos, encodedData);
  }

  void addOfflineVideoIdToList(int videoId) {
    List<int> videosIds = getStoredVideosIds();
    if (!videosIds.contains(videoId)) {
      videosIds.add(videoId);
    }
    List<String> stringsList = videosIds.map((i) => i.toString()).toList();
    prefs.setStringList(SharedPreferencesKeys.offlineVideosIds, stringsList);
    notifyListeners();
  }

  void storeGBytesVideo({required List<int> videoBytes, required int videoId}) async {
    Map<String, dynamic> selectedTimes = {
      "videoId": videoId,
      "bytes": videoBytes.map((i) => i.toString()).toList(),
    };
    String encodedMap = json.encode(selectedTimes);
    await prefs.setString("videoId=$videoId", encodedMap);
  }

  List getGBytesVideo({required int videoId}) {
    String? encodedMap = prefs.getString('videoId=$videoId');
    Map<String, dynamic> decodedMap = json.decode(encodedMap!);
    List data = decodedMap['bytes'].map((e) => int.parse(e.toString())).toList();
    return data;
  }
}
