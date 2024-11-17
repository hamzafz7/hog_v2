import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hog_v2/common/constants/shimmer_effect.dart';

class QuizImageFullScreen extends StatefulWidget {
  final String image;

  const QuizImageFullScreen({required this.image, super.key});

  @override
  State<QuizImageFullScreen> createState() => _QuizImageFullScreenState();
}

class _QuizImageFullScreenState extends State<QuizImageFullScreen> {
  List<ConnectivityResult>? _connectivityResult;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          minScale: 0.5,
          maxScale: 4,
          child: (_connectivityResult == null || _connectivityResult == [])
              ? ShimmerPlaceholder(
                  child: Container(
                    color: Colors.black,
                  ),
                )
              : (!_connectivityResult!.contains(ConnectivityResult.none))
                  ? CachedNetworkImage(
                      httpHeaders: {'Cache-Control': 'max-age=86400'},
                      cacheManager: CachedNetworkImageProvider.defaultCacheManager,
                      imageUrl: widget.image,
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        );
                      },
                      progressIndicatorBuilder: (_, __, ___) => ShimmerPlaceholder(
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    )
                  : const Icon(Icons.offline_bolt),
        ),
      ),
    );
  }
}
