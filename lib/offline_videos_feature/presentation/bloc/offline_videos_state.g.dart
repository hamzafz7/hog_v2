// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_videos_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OfflineVideosState extends OfflineVideosState {
  @override
  final Failure? failure;
  @override
  final bool isGettingVideos;
  @override
  final bool errorGettingVideos;
  @override
  final bool videosFetched;
  @override
  final bool isDownloadingVideo;
  @override
  final bool errorDownloadingVideo;
  @override
  final bool videoDownloaded;
  @override
  final bool isLoadingOfflineVideo;
  @override
  final bool isLoadingVideos;
  @override
  final List<OfflineVideoModel> offlineVideos;
  @override
  final List<OfflineVideoModel> filteredOfflineVideos;
  @override
  final PodPlayerController? podController;
  @override
  final StreamController<double?> percentageDataRead;
  @override
  final bool offlineVideoLoaded;
  @override
  final bool isLoadingOfflinePDFFile;
  @override
  final bool isLoadingMaterials;
  @override
  final bool offlineItemIsDeleted;
  @override
  final List<String> videosMaterials;
  @override
  final String selectedVideoMaterial;
  @override
  final int downloadingItemCount;
  @override
  final List<int> downloadingIds;
  @override
  final List<CustomVideoModel> customVideosDownloading;
  @override
  final bool newVideoAddedToDownload;
  @override
  final bool gotVideoMetaToDownload;
  @override
  final bool isGettingMetaData;
  @override
  final bool videoRemovedFromList;
  @override
  final CourseModel? currentCourse;

  factory _$OfflineVideosState(
          [void Function(OfflineVideosStateBuilder)? updates]) =>
      (new OfflineVideosStateBuilder()..update(updates))._build();

  _$OfflineVideosState._(
      {this.failure,
      required this.isGettingVideos,
      required this.errorGettingVideos,
      required this.videosFetched,
      required this.isDownloadingVideo,
      required this.errorDownloadingVideo,
      required this.videoDownloaded,
      required this.isLoadingOfflineVideo,
      required this.isLoadingVideos,
      required this.offlineVideos,
      required this.filteredOfflineVideos,
      this.podController,
      required this.percentageDataRead,
      required this.offlineVideoLoaded,
      required this.isLoadingOfflinePDFFile,
      required this.isLoadingMaterials,
      required this.offlineItemIsDeleted,
      required this.videosMaterials,
      required this.selectedVideoMaterial,
      required this.downloadingItemCount,
      required this.downloadingIds,
      required this.customVideosDownloading,
      required this.newVideoAddedToDownload,
      required this.gotVideoMetaToDownload,
      required this.isGettingMetaData,
      required this.videoRemovedFromList,
      this.currentCourse})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isGettingVideos, r'OfflineVideosState', 'isGettingVideos');
    BuiltValueNullFieldError.checkNotNull(
        errorGettingVideos, r'OfflineVideosState', 'errorGettingVideos');
    BuiltValueNullFieldError.checkNotNull(
        videosFetched, r'OfflineVideosState', 'videosFetched');
    BuiltValueNullFieldError.checkNotNull(
        isDownloadingVideo, r'OfflineVideosState', 'isDownloadingVideo');
    BuiltValueNullFieldError.checkNotNull(
        errorDownloadingVideo, r'OfflineVideosState', 'errorDownloadingVideo');
    BuiltValueNullFieldError.checkNotNull(
        videoDownloaded, r'OfflineVideosState', 'videoDownloaded');
    BuiltValueNullFieldError.checkNotNull(
        isLoadingOfflineVideo, r'OfflineVideosState', 'isLoadingOfflineVideo');
    BuiltValueNullFieldError.checkNotNull(
        isLoadingVideos, r'OfflineVideosState', 'isLoadingVideos');
    BuiltValueNullFieldError.checkNotNull(
        offlineVideos, r'OfflineVideosState', 'offlineVideos');
    BuiltValueNullFieldError.checkNotNull(
        filteredOfflineVideos, r'OfflineVideosState', 'filteredOfflineVideos');
    BuiltValueNullFieldError.checkNotNull(
        percentageDataRead, r'OfflineVideosState', 'percentageDataRead');
    BuiltValueNullFieldError.checkNotNull(
        offlineVideoLoaded, r'OfflineVideosState', 'offlineVideoLoaded');
    BuiltValueNullFieldError.checkNotNull(isLoadingOfflinePDFFile,
        r'OfflineVideosState', 'isLoadingOfflinePDFFile');
    BuiltValueNullFieldError.checkNotNull(
        isLoadingMaterials, r'OfflineVideosState', 'isLoadingMaterials');
    BuiltValueNullFieldError.checkNotNull(
        offlineItemIsDeleted, r'OfflineVideosState', 'offlineItemIsDeleted');
    BuiltValueNullFieldError.checkNotNull(
        videosMaterials, r'OfflineVideosState', 'videosMaterials');
    BuiltValueNullFieldError.checkNotNull(
        selectedVideoMaterial, r'OfflineVideosState', 'selectedVideoMaterial');
    BuiltValueNullFieldError.checkNotNull(
        downloadingItemCount, r'OfflineVideosState', 'downloadingItemCount');
    BuiltValueNullFieldError.checkNotNull(
        downloadingIds, r'OfflineVideosState', 'downloadingIds');
    BuiltValueNullFieldError.checkNotNull(customVideosDownloading,
        r'OfflineVideosState', 'customVideosDownloading');
    BuiltValueNullFieldError.checkNotNull(newVideoAddedToDownload,
        r'OfflineVideosState', 'newVideoAddedToDownload');
    BuiltValueNullFieldError.checkNotNull(gotVideoMetaToDownload,
        r'OfflineVideosState', 'gotVideoMetaToDownload');
    BuiltValueNullFieldError.checkNotNull(
        isGettingMetaData, r'OfflineVideosState', 'isGettingMetaData');
    BuiltValueNullFieldError.checkNotNull(
        videoRemovedFromList, r'OfflineVideosState', 'videoRemovedFromList');
  }

  @override
  OfflineVideosState rebuild(
          void Function(OfflineVideosStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OfflineVideosStateBuilder toBuilder() =>
      new OfflineVideosStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OfflineVideosState &&
        failure == other.failure &&
        isGettingVideos == other.isGettingVideos &&
        errorGettingVideos == other.errorGettingVideos &&
        videosFetched == other.videosFetched &&
        isDownloadingVideo == other.isDownloadingVideo &&
        errorDownloadingVideo == other.errorDownloadingVideo &&
        videoDownloaded == other.videoDownloaded &&
        isLoadingOfflineVideo == other.isLoadingOfflineVideo &&
        isLoadingVideos == other.isLoadingVideos &&
        offlineVideos == other.offlineVideos &&
        filteredOfflineVideos == other.filteredOfflineVideos &&
        podController == other.podController &&
        percentageDataRead == other.percentageDataRead &&
        offlineVideoLoaded == other.offlineVideoLoaded &&
        isLoadingOfflinePDFFile == other.isLoadingOfflinePDFFile &&
        isLoadingMaterials == other.isLoadingMaterials &&
        offlineItemIsDeleted == other.offlineItemIsDeleted &&
        videosMaterials == other.videosMaterials &&
        selectedVideoMaterial == other.selectedVideoMaterial &&
        downloadingItemCount == other.downloadingItemCount &&
        downloadingIds == other.downloadingIds &&
        customVideosDownloading == other.customVideosDownloading &&
        newVideoAddedToDownload == other.newVideoAddedToDownload &&
        gotVideoMetaToDownload == other.gotVideoMetaToDownload &&
        isGettingMetaData == other.isGettingMetaData &&
        videoRemovedFromList == other.videoRemovedFromList &&
        currentCourse == other.currentCourse;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, failure.hashCode);
    _$hash = $jc(_$hash, isGettingVideos.hashCode);
    _$hash = $jc(_$hash, errorGettingVideos.hashCode);
    _$hash = $jc(_$hash, videosFetched.hashCode);
    _$hash = $jc(_$hash, isDownloadingVideo.hashCode);
    _$hash = $jc(_$hash, errorDownloadingVideo.hashCode);
    _$hash = $jc(_$hash, videoDownloaded.hashCode);
    _$hash = $jc(_$hash, isLoadingOfflineVideo.hashCode);
    _$hash = $jc(_$hash, isLoadingVideos.hashCode);
    _$hash = $jc(_$hash, offlineVideos.hashCode);
    _$hash = $jc(_$hash, filteredOfflineVideos.hashCode);
    _$hash = $jc(_$hash, podController.hashCode);
    _$hash = $jc(_$hash, percentageDataRead.hashCode);
    _$hash = $jc(_$hash, offlineVideoLoaded.hashCode);
    _$hash = $jc(_$hash, isLoadingOfflinePDFFile.hashCode);
    _$hash = $jc(_$hash, isLoadingMaterials.hashCode);
    _$hash = $jc(_$hash, offlineItemIsDeleted.hashCode);
    _$hash = $jc(_$hash, videosMaterials.hashCode);
    _$hash = $jc(_$hash, selectedVideoMaterial.hashCode);
    _$hash = $jc(_$hash, downloadingItemCount.hashCode);
    _$hash = $jc(_$hash, downloadingIds.hashCode);
    _$hash = $jc(_$hash, customVideosDownloading.hashCode);
    _$hash = $jc(_$hash, newVideoAddedToDownload.hashCode);
    _$hash = $jc(_$hash, gotVideoMetaToDownload.hashCode);
    _$hash = $jc(_$hash, isGettingMetaData.hashCode);
    _$hash = $jc(_$hash, videoRemovedFromList.hashCode);
    _$hash = $jc(_$hash, currentCourse.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OfflineVideosState')
          ..add('failure', failure)
          ..add('isGettingVideos', isGettingVideos)
          ..add('errorGettingVideos', errorGettingVideos)
          ..add('videosFetched', videosFetched)
          ..add('isDownloadingVideo', isDownloadingVideo)
          ..add('errorDownloadingVideo', errorDownloadingVideo)
          ..add('videoDownloaded', videoDownloaded)
          ..add('isLoadingOfflineVideo', isLoadingOfflineVideo)
          ..add('isLoadingVideos', isLoadingVideos)
          ..add('offlineVideos', offlineVideos)
          ..add('filteredOfflineVideos', filteredOfflineVideos)
          ..add('podController', podController)
          ..add('percentageDataRead', percentageDataRead)
          ..add('offlineVideoLoaded', offlineVideoLoaded)
          ..add('isLoadingOfflinePDFFile', isLoadingOfflinePDFFile)
          ..add('isLoadingMaterials', isLoadingMaterials)
          ..add('offlineItemIsDeleted', offlineItemIsDeleted)
          ..add('videosMaterials', videosMaterials)
          ..add('selectedVideoMaterial', selectedVideoMaterial)
          ..add('downloadingItemCount', downloadingItemCount)
          ..add('downloadingIds', downloadingIds)
          ..add('customVideosDownloading', customVideosDownloading)
          ..add('newVideoAddedToDownload', newVideoAddedToDownload)
          ..add('gotVideoMetaToDownload', gotVideoMetaToDownload)
          ..add('isGettingMetaData', isGettingMetaData)
          ..add('videoRemovedFromList', videoRemovedFromList)
          ..add('currentCourse', currentCourse))
        .toString();
  }
}

class OfflineVideosStateBuilder
    implements Builder<OfflineVideosState, OfflineVideosStateBuilder> {
  _$OfflineVideosState? _$v;

  Failure? _failure;
  Failure? get failure => _$this._failure;
  set failure(Failure? failure) => _$this._failure = failure;

  bool? _isGettingVideos;
  bool? get isGettingVideos => _$this._isGettingVideos;
  set isGettingVideos(bool? isGettingVideos) =>
      _$this._isGettingVideos = isGettingVideos;

  bool? _errorGettingVideos;
  bool? get errorGettingVideos => _$this._errorGettingVideos;
  set errorGettingVideos(bool? errorGettingVideos) =>
      _$this._errorGettingVideos = errorGettingVideos;

  bool? _videosFetched;
  bool? get videosFetched => _$this._videosFetched;
  set videosFetched(bool? videosFetched) =>
      _$this._videosFetched = videosFetched;

  bool? _isDownloadingVideo;
  bool? get isDownloadingVideo => _$this._isDownloadingVideo;
  set isDownloadingVideo(bool? isDownloadingVideo) =>
      _$this._isDownloadingVideo = isDownloadingVideo;

  bool? _errorDownloadingVideo;
  bool? get errorDownloadingVideo => _$this._errorDownloadingVideo;
  set errorDownloadingVideo(bool? errorDownloadingVideo) =>
      _$this._errorDownloadingVideo = errorDownloadingVideo;

  bool? _videoDownloaded;
  bool? get videoDownloaded => _$this._videoDownloaded;
  set videoDownloaded(bool? videoDownloaded) =>
      _$this._videoDownloaded = videoDownloaded;

  bool? _isLoadingOfflineVideo;
  bool? get isLoadingOfflineVideo => _$this._isLoadingOfflineVideo;
  set isLoadingOfflineVideo(bool? isLoadingOfflineVideo) =>
      _$this._isLoadingOfflineVideo = isLoadingOfflineVideo;

  bool? _isLoadingVideos;
  bool? get isLoadingVideos => _$this._isLoadingVideos;
  set isLoadingVideos(bool? isLoadingVideos) =>
      _$this._isLoadingVideos = isLoadingVideos;

  List<OfflineVideoModel>? _offlineVideos;
  List<OfflineVideoModel>? get offlineVideos => _$this._offlineVideos;
  set offlineVideos(List<OfflineVideoModel>? offlineVideos) =>
      _$this._offlineVideos = offlineVideos;

  List<OfflineVideoModel>? _filteredOfflineVideos;
  List<OfflineVideoModel>? get filteredOfflineVideos =>
      _$this._filteredOfflineVideos;
  set filteredOfflineVideos(List<OfflineVideoModel>? filteredOfflineVideos) =>
      _$this._filteredOfflineVideos = filteredOfflineVideos;

  PodPlayerController? _podController;
  PodPlayerController? get podController => _$this._podController;
  set podController(PodPlayerController? podController) =>
      _$this._podController = podController;

  StreamController<double?>? _percentageDataRead;
  StreamController<double?>? get percentageDataRead =>
      _$this._percentageDataRead;
  set percentageDataRead(StreamController<double?>? percentageDataRead) =>
      _$this._percentageDataRead = percentageDataRead;

  bool? _offlineVideoLoaded;
  bool? get offlineVideoLoaded => _$this._offlineVideoLoaded;
  set offlineVideoLoaded(bool? offlineVideoLoaded) =>
      _$this._offlineVideoLoaded = offlineVideoLoaded;

  bool? _isLoadingOfflinePDFFile;
  bool? get isLoadingOfflinePDFFile => _$this._isLoadingOfflinePDFFile;
  set isLoadingOfflinePDFFile(bool? isLoadingOfflinePDFFile) =>
      _$this._isLoadingOfflinePDFFile = isLoadingOfflinePDFFile;

  bool? _isLoadingMaterials;
  bool? get isLoadingMaterials => _$this._isLoadingMaterials;
  set isLoadingMaterials(bool? isLoadingMaterials) =>
      _$this._isLoadingMaterials = isLoadingMaterials;

  bool? _offlineItemIsDeleted;
  bool? get offlineItemIsDeleted => _$this._offlineItemIsDeleted;
  set offlineItemIsDeleted(bool? offlineItemIsDeleted) =>
      _$this._offlineItemIsDeleted = offlineItemIsDeleted;

  List<String>? _videosMaterials;
  List<String>? get videosMaterials => _$this._videosMaterials;
  set videosMaterials(List<String>? videosMaterials) =>
      _$this._videosMaterials = videosMaterials;

  String? _selectedVideoMaterial;
  String? get selectedVideoMaterial => _$this._selectedVideoMaterial;
  set selectedVideoMaterial(String? selectedVideoMaterial) =>
      _$this._selectedVideoMaterial = selectedVideoMaterial;

  int? _downloadingItemCount;
  int? get downloadingItemCount => _$this._downloadingItemCount;
  set downloadingItemCount(int? downloadingItemCount) =>
      _$this._downloadingItemCount = downloadingItemCount;

  List<int>? _downloadingIds;
  List<int>? get downloadingIds => _$this._downloadingIds;
  set downloadingIds(List<int>? downloadingIds) =>
      _$this._downloadingIds = downloadingIds;

  List<CustomVideoModel>? _customVideosDownloading;
  List<CustomVideoModel>? get customVideosDownloading =>
      _$this._customVideosDownloading;
  set customVideosDownloading(
          List<CustomVideoModel>? customVideosDownloading) =>
      _$this._customVideosDownloading = customVideosDownloading;

  bool? _newVideoAddedToDownload;
  bool? get newVideoAddedToDownload => _$this._newVideoAddedToDownload;
  set newVideoAddedToDownload(bool? newVideoAddedToDownload) =>
      _$this._newVideoAddedToDownload = newVideoAddedToDownload;

  bool? _gotVideoMetaToDownload;
  bool? get gotVideoMetaToDownload => _$this._gotVideoMetaToDownload;
  set gotVideoMetaToDownload(bool? gotVideoMetaToDownload) =>
      _$this._gotVideoMetaToDownload = gotVideoMetaToDownload;

  bool? _isGettingMetaData;
  bool? get isGettingMetaData => _$this._isGettingMetaData;
  set isGettingMetaData(bool? isGettingMetaData) =>
      _$this._isGettingMetaData = isGettingMetaData;

  bool? _videoRemovedFromList;
  bool? get videoRemovedFromList => _$this._videoRemovedFromList;
  set videoRemovedFromList(bool? videoRemovedFromList) =>
      _$this._videoRemovedFromList = videoRemovedFromList;

  CourseModel? _currentCourse;
  CourseModel? get currentCourse => _$this._currentCourse;
  set currentCourse(CourseModel? currentCourse) =>
      _$this._currentCourse = currentCourse;

  OfflineVideosStateBuilder();

  OfflineVideosStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _failure = $v.failure;
      _isGettingVideos = $v.isGettingVideos;
      _errorGettingVideos = $v.errorGettingVideos;
      _videosFetched = $v.videosFetched;
      _isDownloadingVideo = $v.isDownloadingVideo;
      _errorDownloadingVideo = $v.errorDownloadingVideo;
      _videoDownloaded = $v.videoDownloaded;
      _isLoadingOfflineVideo = $v.isLoadingOfflineVideo;
      _isLoadingVideos = $v.isLoadingVideos;
      _offlineVideos = $v.offlineVideos;
      _filteredOfflineVideos = $v.filteredOfflineVideos;
      _podController = $v.podController;
      _percentageDataRead = $v.percentageDataRead;
      _offlineVideoLoaded = $v.offlineVideoLoaded;
      _isLoadingOfflinePDFFile = $v.isLoadingOfflinePDFFile;
      _isLoadingMaterials = $v.isLoadingMaterials;
      _offlineItemIsDeleted = $v.offlineItemIsDeleted;
      _videosMaterials = $v.videosMaterials;
      _selectedVideoMaterial = $v.selectedVideoMaterial;
      _downloadingItemCount = $v.downloadingItemCount;
      _downloadingIds = $v.downloadingIds;
      _customVideosDownloading = $v.customVideosDownloading;
      _newVideoAddedToDownload = $v.newVideoAddedToDownload;
      _gotVideoMetaToDownload = $v.gotVideoMetaToDownload;
      _isGettingMetaData = $v.isGettingMetaData;
      _videoRemovedFromList = $v.videoRemovedFromList;
      _currentCourse = $v.currentCourse;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OfflineVideosState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OfflineVideosState;
  }

  @override
  void update(void Function(OfflineVideosStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OfflineVideosState build() => _build();

  _$OfflineVideosState _build() {
    final _$result = _$v ??
        new _$OfflineVideosState._(
            failure: failure,
            isGettingVideos: BuiltValueNullFieldError.checkNotNull(
                isGettingVideos, r'OfflineVideosState', 'isGettingVideos'),
            errorGettingVideos: BuiltValueNullFieldError.checkNotNull(
                errorGettingVideos, r'OfflineVideosState', 'errorGettingVideos'),
            videosFetched: BuiltValueNullFieldError.checkNotNull(
                videosFetched, r'OfflineVideosState', 'videosFetched'),
            isDownloadingVideo: BuiltValueNullFieldError.checkNotNull(
                isDownloadingVideo, r'OfflineVideosState', 'isDownloadingVideo'),
            errorDownloadingVideo: BuiltValueNullFieldError.checkNotNull(
                errorDownloadingVideo, r'OfflineVideosState', 'errorDownloadingVideo'),
            videoDownloaded: BuiltValueNullFieldError.checkNotNull(
                videoDownloaded, r'OfflineVideosState', 'videoDownloaded'),
            isLoadingOfflineVideo: BuiltValueNullFieldError.checkNotNull(
                isLoadingOfflineVideo, r'OfflineVideosState', 'isLoadingOfflineVideo'),
            isLoadingVideos: BuiltValueNullFieldError.checkNotNull(isLoadingVideos, r'OfflineVideosState', 'isLoadingVideos'),
            offlineVideos: BuiltValueNullFieldError.checkNotNull(offlineVideos, r'OfflineVideosState', 'offlineVideos'),
            filteredOfflineVideos: BuiltValueNullFieldError.checkNotNull(filteredOfflineVideos, r'OfflineVideosState', 'filteredOfflineVideos'),
            podController: podController,
            percentageDataRead: BuiltValueNullFieldError.checkNotNull(percentageDataRead, r'OfflineVideosState', 'percentageDataRead'),
            offlineVideoLoaded: BuiltValueNullFieldError.checkNotNull(offlineVideoLoaded, r'OfflineVideosState', 'offlineVideoLoaded'),
            isLoadingOfflinePDFFile: BuiltValueNullFieldError.checkNotNull(isLoadingOfflinePDFFile, r'OfflineVideosState', 'isLoadingOfflinePDFFile'),
            isLoadingMaterials: BuiltValueNullFieldError.checkNotNull(isLoadingMaterials, r'OfflineVideosState', 'isLoadingMaterials'),
            offlineItemIsDeleted: BuiltValueNullFieldError.checkNotNull(offlineItemIsDeleted, r'OfflineVideosState', 'offlineItemIsDeleted'),
            videosMaterials: BuiltValueNullFieldError.checkNotNull(videosMaterials, r'OfflineVideosState', 'videosMaterials'),
            selectedVideoMaterial: BuiltValueNullFieldError.checkNotNull(selectedVideoMaterial, r'OfflineVideosState', 'selectedVideoMaterial'),
            downloadingItemCount: BuiltValueNullFieldError.checkNotNull(downloadingItemCount, r'OfflineVideosState', 'downloadingItemCount'),
            downloadingIds: BuiltValueNullFieldError.checkNotNull(downloadingIds, r'OfflineVideosState', 'downloadingIds'),
            customVideosDownloading: BuiltValueNullFieldError.checkNotNull(customVideosDownloading, r'OfflineVideosState', 'customVideosDownloading'),
            newVideoAddedToDownload: BuiltValueNullFieldError.checkNotNull(newVideoAddedToDownload, r'OfflineVideosState', 'newVideoAddedToDownload'),
            gotVideoMetaToDownload: BuiltValueNullFieldError.checkNotNull(gotVideoMetaToDownload, r'OfflineVideosState', 'gotVideoMetaToDownload'),
            isGettingMetaData: BuiltValueNullFieldError.checkNotNull(isGettingMetaData, r'OfflineVideosState', 'isGettingMetaData'),
            videoRemovedFromList: BuiltValueNullFieldError.checkNotNull(videoRemovedFromList, r'OfflineVideosState', 'videoRemovedFromList'),
            currentCourse: currentCourse);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
