import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/shimmer_effect.dart';
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
                ),
        ),
      ),
    );
  }
}

class CachedImageCircle extends StatefulWidget {
  const CachedImageCircle({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<CachedImageCircle> createState() => _CachedImageCircleState();
}

class _CachedImageCircleState extends State<CachedImageCircle> {
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
    if (_connectivityResult == null || _connectivityResult == []) {
      return ShimmerPlaceholder(
        child: CircleAvatar(
          radius: 56.r,
          backgroundColor: Colors.black,
        ),
      );
    }
    return (!_connectivityResult!.contains(ConnectivityResult.none))
        ? CachedNetworkImage(
            httpHeaders: {'Cache-Control': 'max-age=86400'},
            cacheManager: CachedNetworkImageProvider.defaultCacheManager,
            imageUrl: widget.imageUrl,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 56.r,
                backgroundImage: ResizeImage(
                  imageProvider,
                  // width: (56.r * MediaQuery.of(context).devicePixelRatio).round(),
                  // height: (56.r * MediaQuery.of(context).devicePixelRatio).round(),
                  width: (56.r).round(),
                  height: (56.r).round(),
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
          )
        : const Icon(Icons.offline_bolt);
  }
}
