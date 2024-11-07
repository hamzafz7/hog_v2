import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hog_v2/common/constants/shimmer_effect.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';

class QuizImageFullScreen extends StatelessWidget {
  final String image;

  const QuizImageFullScreen({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          minScale: 0.5,
          maxScale: 4,
          child: CachedNetworkImage(
            cacheManager: CustomCacheManager.instance,
            imageUrl: image,
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
          ),
        ),
      ),
    );
  }
}
