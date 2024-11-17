import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hog_v2/common/constants/shimmer_effect.dart';

class CachedImageWithFallback extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;

  const CachedImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.fill,
  });

  @override
  State<CachedImageWithFallback> createState() => _CachedImageWithFallbackState();
}

class _CachedImageWithFallbackState extends State<CachedImageWithFallback> {
  List<ConnectivityResult>? _connectivityResult;
  final AsyncMemoizer memorizer = AsyncMemoizer();

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
    if (_connectivityResult == null || _connectivityResult == []) {
      return ShimmerPlaceholder(
        child: Container(
          height: widget.height,
          color: Colors.black,
        ),
      );
    }
    return FutureBuilder(
      future: memorizer.runOnce(() async {
        return (!_connectivityResult!.contains(ConnectivityResult.none))
            ? CachedNetworkImage(
                httpHeaders: {'Cache-Control': 'max-age=86400'},
                cacheManager: CachedNetworkImageProvider.defaultCacheManager,
                imageUrl: widget.imageUrl,
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: ResizeImage(
                      imageProvider,
                      // width: (widget.width * MediaQuery.of(context).devicePixelRatio).round(),
                      // height: (widget.height * MediaQuery.of(context).devicePixelRatio).round(),
                      width: (widget.width).round(),
                      height: (widget.height).round(),
                    ),
                    width: widget.width,
                    height: widget.height,
                    fit: widget.fit,
                  );
                },
                progressIndicatorBuilder: (_, __, ___) => ShimmerPlaceholder(
                  child: Container(
                    height: widget.height,
                    color: Colors.black,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return SizedBox(
                      width: widget.width, height: widget.height, child: const Icon(Icons.error));
                },
              )
            : SizedBox(
                width: widget.width,
                height: widget.height,
                child: const Icon(Icons.offline_bolt),
              );
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerPlaceholder(
            child: Container(
              height: widget.height,
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
              width: widget.width, height: widget.height, child: const Icon(Icons.error));
        }
        return snapshot.data as Widget;
      },
    );
  }
}

// class CustomCacheManager extends CacheManager {
//   static const key = "customCacheKey";
//
//   static CustomCacheManager instance = CustomCacheManager._();
//
//   CustomCacheManager._()
//       : super(
//           Config(
//             key,
//             stalePeriod: const Duration(days: 1),
//             maxNrOfCacheObjects: 1000,
//           ),
//         );
// }
