import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/shimmer_effect.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';

class MyProfileImage extends GetView<MyProfileController> {
  const MyProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kprimaryBlueColor)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Obx(
          () => controller.imagePicked.value != ""
              ? CircleAvatar(
                  radius: 56.r,
                  backgroundImage: FileImage(File(controller.imagePicked.value)) as ImageProvider)
              : CachedImageCircle(
                  imageUrl: controller.prfoileResponse?.data.image != null
                      ? controller.prfoileResponse!.data.image!
                      : controller.imageProfile,
                  imageFound: controller.prfoileResponse!.data.imageExist!,
                ),
        ),
      ),
    );
  }
}

class CachedImageCircle extends StatelessWidget {
  const CachedImageCircle({
    super.key,
    required this.imageUrl,
    required this.imageFound,
  });

  final String imageUrl;
  final bool imageFound;

  @override
  Widget build(BuildContext context) {
    return !imageFound
        ? const Icon(Icons.error)
        : CachedNetworkImage(
            cacheManager: CustomCacheManager.instance,
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 56.r,
                backgroundImage: ResizeImage(
                  imageProvider,
                  width: (56.r * MediaQuery.of(context).devicePixelRatio).round(),
                  height: (56.r * MediaQuery.of(context).devicePixelRatio).round(),
                ),
              );
            },
            progressIndicatorBuilder: (___, __, _) => ShimmerPlaceholder(
              child: CircleAvatar(
                radius: 56.r,
                backgroundColor: Colors.black,
              ),
            ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          );
  }
}
