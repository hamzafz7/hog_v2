import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:pod_player/pod_player.dart';
import '../../dependency_injection/injection_container.dart';
import '../../models/offline_video_model.dart';
import '../bloc/offline_videos_bloc.dart';
import '../bloc/offline_videos_event.dart';
import '../bloc/offline_videos_state.dart';

class PlayOfflineVideoPage extends StatefulWidget {
  final OfflineVideoModel offlineVideoModel;

  const PlayOfflineVideoPage({super.key, required this.offlineVideoModel});

  @override
  State<PlayOfflineVideoPage> createState() => _PlayOfflineVideoPageState();
}

class _PlayOfflineVideoPageState extends State<PlayOfflineVideoPage> {
  final _bloc = getIt<OfflineVideosBloc>();

  @override
  void initState() {
    // initializeVideo();
    _bloc.add(InitializeOfflineVideo(widget.offlineVideoModel.videoId));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.add(DisposeVideoController());

    IsolateNameServer.removePortNameMapping("readVideo");

    FlutterIsolate.killAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (BuildContext context, OfflineVideosState state) {
        if (state.offlineVideoLoaded) {
          // print("sss : ${state.podController!.totalVideoLength.inSeconds}");
          _bloc.add(PlayOfflineVideo());
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, OfflineVideosState state) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.zero,
                child: AppBar(
                  backgroundColor: Colors.black,
                ),
              ),
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: state.isLoadingOfflineVideo ||
                              state.podController == null
                          ? StreamBuilder(
                              stream: state.percentageDataRead.stream,
                              builder: (context, value) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value: value.data,
                                        color: Colors.blue,
                                        backgroundColor: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "${((((value.data ?? 0) > 1 ? 1 : value.data) ?? 0) * 100).toStringAsFixed(1)} %",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                );
                              })
                          : PodVideoPlayer(controller: state.podController!)),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
