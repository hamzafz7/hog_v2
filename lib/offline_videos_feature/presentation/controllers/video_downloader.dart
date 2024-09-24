import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:hog/offline_videos_feature/presentation/bloc/offline_videos_event.dart';
import 'package:path_provider/path_provider.dart';
import '../../../main.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../dependency_injection/injection_container.dart';
import '../bloc/offline_videos_bloc.dart';

enum DownloadStatus { init, downloading, downloaded, videoExist }

class VideoDownloader {
  final ValueNotifier<DownloadStatus> downloadStatus =
      ValueNotifier(DownloadStatus.init);

  ValueNotifier<Map<String, dynamic>> newDownloadPercentage =
      ValueNotifier({"percent": 0.0, "value": "0%"});

  final StreamController<Map<String, dynamic>> downloadPercentage =
      StreamController<Map<String, dynamic>>();

  ReceivePort? receivePort;
  FlutterIsolate? myIsolate;

  Future download2(String url, int videoId,
      {required Function onDone,
      required Function(Map<String, dynamic>) onChange,
      required String courseName,
      required String sectionName,
      required String titleVideo}) async {
    try {
      // print("Start downloading.... download2");
      receivePort = ReceivePort("iso_$videoId");
      // RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
      IsolateNameServer.registerPortWithName(
          receivePort!.sendPort, "iso_$videoId");
      print("QQQQQ");
      receivePort!.listen((message) {
        if (message == "done") {
          // print("DONOONO");
          // addOfflineVideoIdToList(data.id);
          // storeNewVideo(¬
          //     offlineVideoModel: VideoEntityOffline(
          //         id: data.id,
          //         title: data.title,
          //         sectionName: sectionName,
          //         teacherName: teacherName,
          //         gZipBytes: [],
          //         url: data.url));

          getIt<OfflineVideosBloc>().add(AddVideoToLocalStorage(
              videoId: videoId,
              lessonTitle: courseName,
              lessonId: -1,
              sectionName: sectionName,
              sectionTeacherName: "courseModel.teacher",
              ytVideoTitle: titleVideo));

          downloadStatus.value = DownloadStatus.downloaded;
          newDownloadPercentage.value = {"percent": 0.0, "value": "0%"};
          onDone();
          if(myIsolate != null) {
            print("KKKKK");

            myIsolate = null;
          }
        } else if (message == "error") {
          // print("Error");
          BotToast.showText(text: "حدث خطأ ما اثناء التحميل");
          cancelDownload();
        } else {
          if (message is Map<String, dynamic>) {
            downloadPercentage.add(message);
            newDownloadPercentage.value = message;
            onChange(message);
          }
        }
      });

      print("SSSS");
      myIsolate = await FlutterIsolate.spawn(writeVideoBytes, [videoId, url]);
      print("WWWWW");
    } catch (e, s) {
      // Catcher2.reportCheckedError(e, s);
      downloadStatus.value = DownloadStatus.init;
      newDownloadPercentage.value = {"percent": 0.0, "value": "0%"};
    }
  }

  void cancelDownload() {
    // print("Canceling...");
    downloadPercentage.add({"percent": 0.0, "value": "0%"});
    downloadStatus.value = DownloadStatus.init;
    newDownloadPercentage.value = {"percent": 0.0, "value": "0%"};
    if (myIsolate != null) {
      myIsolate!.kill();
    }
  }

  Future<String> createBasePathFolder(String cow) async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!.path}/$cow');

    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }
}
