import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hog/offline_videos_feature/presentation/pages/play_offline_video_page.dart';
import 'package:path_provider/path_provider.dart';
import '../../dependency_injection/injection_container.dart';
import '../bloc/offline_videos_bloc.dart';
import '../bloc/offline_videos_event.dart';
import '../bloc/offline_videos_state.dart';

class OfflineVideosPage extends StatefulWidget {
  const OfflineVideosPage({Key? key}) : super(key: key);

  @override
  State<OfflineVideosPage> createState() => _OfflineVideosPageState();
}

class _OfflineVideosPageState extends State<OfflineVideosPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _bloc = getIt<OfflineVideosBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetOfflineVideos());
    _bloc.add(GetVideosMaterials());
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (BuildContext context, OfflineVideosState state) {
        if (state.offlineItemIsDeleted) {
          setState(() {});
          _bloc.add(GetVideosMaterials());
          // _bloc.add(GetAttachmentsMaterials());
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, OfflineVideosState state) {
          return Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: PreferredSize(
                preferredSize: Size.zero,
                child: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0.0,
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.h * 0.2),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          Expanded(
                            child: SafeArea(
                              child: SizedBox(
                                width: context.w,
                                child: Column(
                                  children: [
                                    getVideosMaterialsWidget(state),
                                    Expanded(child: getVideosWidget(state)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: context.w * 0.08,
                              height: context.w * 0.08,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.primaryColor,
                                  size: context.w * 0.05,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              "في هذه القائمة ستجد الفيديوهات التعليمية التي قمت بتحميلها لمشاهدتها لاحقاً دون الحاجة للاتصال بالانترنت",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'assets/icons/cloud.png',
                              width: context.w * 0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget getVideosMaterialsWidget(OfflineVideosState state) {
    if (state.videosMaterials.isEmpty) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            width: double.infinity,
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.videosMaterials.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: GestureDetector(
                              onTap: () {
                                _bloc.add(SelectVideoMaterial(
                                    state.videosMaterials[index]));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: state.selectedVideoMaterial ==
                                            state.videosMaterials[index]
                                        ? AppColors.primaryColor
                                        : null,
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.videosMaterials[index],
                                    style: TextStyle(
                                        color: state.selectedVideoMaterial ==
                                                state.videosMaterials[index]
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    _bloc.add(SelectVideoMaterial("All"));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: state.selectedVideoMaterial == "All"
                            ? AppColors.primaryColor
                            : null,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "الكل",
                        style: TextStyle(
                            color: state.selectedVideoMaterial == "All"
                                ? Colors.white
                                : AppColors.primaryColor,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget getVideosWidget(OfflineVideosState state) {
    if (state.offlineVideos.isEmpty) {
      return Center(
        child: Text(
          "لا يوجد فيدوهات محملة",
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: state.selectedVideoMaterial == "All"
              ? state.offlineVideos.length
              : state.filteredOfflineVideos.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: videoWidget(index, state),
            );
          });
    }
  }

  Widget videoWidget(int index, OfflineVideosState state) {
    debugPrint(
        "state.offlineVideos[index].lessonTitle! = ${state.offlineVideos[index].lessonTitle!}");
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayOfflineVideoPage(
                        offlineVideoModel: state.offlineVideos[index],
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xffF4F6FA)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  state.selectedVideoMaterial == "All"
                      ? state.offlineVideos[index].isDeleting
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                _bloc.add(DeleteOfflineVideo(index,
                                    fromFilter: false,
                                    videoId:
                                        state.offlineVideos[index].videoId));
                                setState(() {});
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            )
                      : state.filteredOfflineVideos[index].isDeleting
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                _bloc.add(DeleteOfflineVideo(index,
                                    fromFilter: true,
                                    videoId: state
                                        .filteredOfflineVideos[index].videoId));
                                setState(() {});
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.selectedVideoMaterial == "All"
                              ? state.offlineVideos[index].lessonTitle == null
                                  ? ""
                                  : state.offlineVideos[index].lessonTitle!
                              : state.filteredOfflineVideos[index]
                                          .lessonTitle ==
                                      null
                                  ? ""
                                  : state.filteredOfflineVideos[index]
                                      .lessonTitle!,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: context.w * 0.26,
                    height: context.w * 0.2,
                    child: Stack(
                      children: [
                        Container(
                          width: context.w * 0.26,
                          height: context.w * 0.2,
                          foregroundDecoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: Image.asset(
                                'assets/icons/logo.png',
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static Color primaryColor = const Color(0xFF0075FF);
}

extension ExtensionOnContext on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get w => size.width;

  double get h => size.height;
}
