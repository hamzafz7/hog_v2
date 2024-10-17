import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../main.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/custom_video_model.dart';
import '../../models/offline_video_model.dart';
import '../controllers/video_downloader.dart';
import 'offline_videos_event.dart';
import 'offline_videos_state.dart';

@Injectable()
class OfflineVideosBloc extends Bloc<OfflineVideosEvent, OfflineVideosState> {
  final PrefsHelper prefsHelper;

  OfflineVideosBloc(this.prefsHelper) : super(OfflineVideosState.initial()) {
    on<GetOfflineVideos>(_onGetOfflineVideos);
    on<AddVideoToLocalStorage>(_onAddVideoToLocalStorage);
    on<InitializeOfflineVideo>(_onInitializeOfflineVideo);
    on<PlayOfflineVideo>(_onPlayOfflineVideo);
    on<DisposeVideoController>(_onDisposeVideoController);
    on<GetVideosMaterials>(_onGetVideosMaterials);
    on<SelectVideoMaterial>(_onSelectVideoMaterial);
    on<DeleteOfflineVideo>(_onDeleteOfflineVideo);
    on<DownloadYoutubeVideo>(_onDownloadYoutubeVideo);
    on<ClearDownloadingData>(_onClearDownloadingData);
    on<CancelDownload>(_onCancelDownload);
    on<UpdateVideosCount>(_onUpdateVideosCount);
    on<ClearDispose>(_onClearDispose);
  }

  Future<void> _onClearDispose(
      ClearDispose event, Emitter<OfflineVideosState> emit) async {}

  Future<void> _onDownloadYoutubeVideo(
      DownloadYoutubeVideo event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p) => p
      ..customVideosDownloading!
          .add(CustomVideoModel(videoModel: event.videoModel))));
    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .isDownloading = true;
    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .isFetchingAPI = true;
    emit(state.rebuild((p) => p));
    emit(state.rebuild((p) => p
      ..newVideoAddedToDownload = true
      ..gotVideoMetaToDownload = false));

    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .isFetchingAPI = false;
    emit(state.rebuild((p) => p..newVideoAddedToDownload = true));

    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .isDownloading = true;
    // emit(state.rebuild((p) => p));
    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .videoDownloader
        .downloadStatus
        .value = DownloadStatus.downloading;
    await state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .videoDownloader
        .download2(
            sectionName: event.sectionName,
            courseName: event.courseName,
            titleVideo: "event.videoModel.title",
            event.link,
            event.videoModel.id, onDone: () async {
      state.customVideosDownloading
          .where((element) => element.videoModel.id == event.videoModel.id)
          .first
          .videoDownloader
          .cancelDownload();
      state.customVideosDownloading
          .where((element) => element.videoModel.id == event.videoModel.id)
          .first
          .isDownloading = false;
      state.rebuild((p) => p
        ..customVideosDownloading!.removeWhere(
            (element) => element.videoModel.id == event.videoModel.id));
      state.rebuild((p) => p..newVideoAddedToDownload = true);
    }, onChange: (Map<String, dynamic> map) {
      if (state.customVideosDownloading
          .where((element) => element.videoModel.id == event.videoModel.id)
          .isNotEmpty) {
        state.customVideosDownloading
            .where((element) => element.videoModel.id == event.videoModel.id)
            .first
            .videoDownloader
            .newDownloadPercentage
            .value = map;
      }
    });
    _onUpdateVideosCount(UpdateVideosCount(), emit);
  }

  Future<void> _onCancelDownload(
      CancelDownload event, Emitter<OfflineVideosState> emit) async {
    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .videoDownloader
        .cancelDownload();
    state.customVideosDownloading
        .where((element) => element.videoModel.id == event.videoModel.id)
        .first
        .isDownloading = false;
    emit(state.rebuild((p) => p
      ..customVideosDownloading!.removeWhere(
          (element) => element.videoModel.id == event.videoModel.id)));
    emit(state.rebuild((p) => p..newVideoAddedToDownload = true));
  }

  Future<void> _onClearDownloadingData(
      ClearDownloadingData event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p) => p
      ..newVideoAddedToDownload = false
      ..errorDownloadingVideo = false
      ..videoRemovedFromList = false));
  }

  Future<void> _onUpdateVideosCount(
      UpdateVideosCount event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p) => p..newVideoAddedToDownload = true));
  }

  Future<void> _onRemoveVideoFromCustomList(
      RemoveVideoFromCustomList event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p) => p
      ..customVideosDownloading!
          .removeWhere((element) => element.videoModel.id == event.videoId)
      ..videoRemovedFromList = true));
  }

  Future<void> _onGetOfflineVideos(
      GetOfflineVideos event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p0) => p0..isLoadingVideos = true));
    final result = await prefsHelper.fetchOfflineVideos();
    emit(state.rebuild((p0) => p0
      ..offlineVideos = result
      ..isLoadingVideos = false));
  }

  Future<void> _onAddVideoToLocalStorage(
      AddVideoToLocalStorage event, Emitter<OfflineVideosState> emit) async {
    prefsHelper.addOfflineVideoIdToList(event.videoId);
    prefsHelper.storeNewVideo(
        offlineVideoModel: OfflineVideoModel(
      lessonTitle: event.sectionName,
      materialName: event.lessonTitle,
      materialTeacherName: event.sectionTeacherName,
      title: event.ytVideoTitle,
      videoId: event.videoId,
    ));
  }

  Future<void> _onInitializeOfflineVideo(
      InitializeOfflineVideo event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p0) => p0..isLoadingOfflineVideo = true));
    var tempDir = await getApplicationDocumentsDirectory();
    String fullPath = "${tempDir.path}/test.mp4";
    String basePath = await createBasePathFolder("Hog Offline Videos");
    String pathToRead = "$basePath/video${event.videoId}.professor";

    try {
      ReceivePort? receivePort;
      receivePort = ReceivePort("readVideo");
      // RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
      IsolateNameServer.registerPortWithName(receivePort.sendPort, "readVideo");
      // VideoPlayerController playerController =
      //     VideoPlayerController.file(File(fullPath));
      PodPlayerController playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.file(File(fullPath)),
      );
      int cnt = 0;

      receivePort.listen((message) async {
        if (message == "done") {
          if (!playerController.isInitialised && cnt == 0) {
            cnt++;
            await playerController.initialise();
          }
        } else {
          if (message is double) {
            state.percentageDataRead.add(message);
          }
        }
      });

// Start the isolate
      await FlutterIsolate.spawn(decryptFile, [event.videoId]);

// Poll until the playerController is initialized or we timeout
      do {
        await Future.delayed(const Duration(milliseconds: 500));
      } while (!playerController.isInitialised);

// Check if the player is initialized successfully
      if (playerController.isInitialised) {
        playerController.play(); // Start video playback

        emit(state.rebuild((p0) => p0
          ..isLoadingOfflineVideo = false
          ..offlineVideoLoaded = true
          ..podController = playerController));
      } else {
        // Handle initialization failure
        emit(state.rebuild((p0) => p0..errorDownloadingVideo = true));
      }
    } catch (e) {
      Uint8List? data = await _readFileByte(pathToRead);
      File file = await File(fullPath).create();
      if (data != null) {
        file.writeAsBytesSync(data);
        PodPlayerController playerController = PodPlayerController(
            playVideoFrom: PlayVideoFrom.file(File(fullPath)));
        emit(state.rebuild((p0) => p0
          ..isLoadingOfflineVideo = false
          ..offlineVideoLoaded = true
          ..podController = playerController));
      }
    }
  }

  Future<void> _onPlayOfflineVideo(
      PlayOfflineVideo event, Emitter<OfflineVideosState> emit) async {
    state..podController!.play();
    emit(state.rebuild((p0) => p0..offlineVideoLoaded = false));
  }

  Future<void> _onDisposeVideoController(
      DisposeVideoController event, Emitter<OfflineVideosState> emit) async {
    state.podController!.dispose();
    emit(state.rebuild((p0) => p0..podController!.dispose()));
  }

  Future<void> _onGetVideosMaterials(
      GetVideosMaterials event, Emitter<OfflineVideosState> emit) async {
    emit(state.rebuild((p0) => p0..isLoadingMaterials = true));
    final result = await prefsHelper.getVideosMaterials();

    emit(state.rebuild((p0) => p0
      ..videosMaterials = result
      ..offlineItemIsDeleted = false));
  }

  Future<void> _onSelectVideoMaterial(
      SelectVideoMaterial event, Emitter<OfflineVideosState> emit) async {
    List<OfflineVideoModel> filteredVideos =
        await prefsHelper.fetchOfflineVideos();
    filteredVideos = filteredVideos
        .where((element) => element.materialName == event.material)
        .toSet()
        .toList();
    emit(state.rebuild((p0) => p0
      ..selectedVideoMaterial = event.material
      ..filteredOfflineVideos = filteredVideos));
  }

  Future<void> _onDeleteOfflineVideo(
      DeleteOfflineVideo event, Emitter<OfflineVideosState> emit) async {
    if (event.fromFilter) {
      emit(state.rebuild((p0) => p0
        ..filteredOfflineVideos!
            .where((element) => element.videoId == event.videoId)
            .first
            .isDeleting = true));
      String basePath = await createBasePathFolder("Hog Offline Videos");
      String pathToRead = "$basePath/video${event.videoId}.professor";
      deleteFile(pathToRead);
      prefsHelper.deleteVideoFromShared(event.videoId);
      emit(state.rebuild((p0) => p0
        ..filteredOfflineVideos!
            .removeWhere((element) => element.videoId == event.videoId)
        ..offlineItemIsDeleted = true));
    } else {
      emit(state.rebuild((p0) => p0
        ..offlineVideos!
            .where((element) => element.videoId == event.videoId)
            .first
            .isDeleting = true));
      String basePath = await createBasePathFolder("Hog Offline Videos");
      String pathToRead = "$basePath/video${event.videoId}.professor";
      deleteFile(pathToRead);
      prefsHelper.deleteVideoFromShared(event.videoId);
      emit(state.rebuild((p0) => p0
        ..offlineVideos!
            .removeWhere((element) => element.videoId == event.videoId)
        ..offlineItemIsDeleted = true));
    }
  }

  Future<String> createBasePathFolder(String cow) async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!.path}/$cow');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  Future<Uint8List?> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File file = File.fromUri(myUri);
    Uint8List? bytes;
    await file.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      // bytes = Uint8List.fromList(value);
      // print('reading of bytes is completed');
    }).catchError((onError) {
      // print('Exception Error while reading audio from path:' +
      //     onError.toString());
    });
    return bytes;
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);

      // Check if the file exists
      if (await file.exists()) {
        await file.delete();
        log('File deleted successfully');
      } else {
        log('File not found');
      }
    } catch (e) {
      log('Error deleting file: $e');
    }
  }
}
