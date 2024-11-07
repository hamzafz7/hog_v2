import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show CacheManager, Config;
import 'package:hog_v2/common/constants/shimmer_effect.dart';

class CachedImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final bool imageFound;
  final double height;
  final double width;
  final BoxFit? fit;

  const CachedImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.fill,
    required this.imageFound,
  });

  @override
  Widget build(BuildContext context) {
    return !imageFound
        ? SizedBox(
            height: height,
            width: width,
            child: const Icon(Icons.error),
          )
        : CachedNetworkImage(
            cacheManager: CustomCacheManager.instance,
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) {
              return Image(
                image: ResizeImage(
                  imageProvider,
                  width: (width * MediaQuery.of(context).devicePixelRatio).round(),
                  height: (height * MediaQuery.of(context).devicePixelRatio).round(),
                ),
                width: width,
                height: height,
                fit: fit,
              );
            },
            progressIndicatorBuilder: (_, __, ___) => ShimmerPlaceholder(
              child: Container(
                height: height,
                color: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) {
              return SizedBox(width: width, height: height, child: const Icon(Icons.error));
            },
          );
  }
}

class CustomCacheManager extends CacheManager {
  static const key = "customCacheKey";

  static CustomCacheManager instance = CustomCacheManager._();

  CustomCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 1),
            maxNrOfCacheObjects: 1000,
          ),
        );
}
