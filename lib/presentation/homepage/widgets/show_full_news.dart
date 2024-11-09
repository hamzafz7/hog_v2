import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/data/models/news_model.dart';
import 'package:hog_v2/presentation/course_details/widgets/cachedImageWithFallback.dart';

class ShowFullNewsPage extends StatelessWidget {
  const ShowFullNewsPage({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: Get.width,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: CachedImageWithFallback(
                imageUrl: newsModel.image ?? defPic,
                height: 300.h,
                width: Get.width,
              ),
              // CachedNetworkImage(
              //   imageUrl: newsModel.image ?? defPic,
              //   height: 300.h,
              //   width: Get.width,
              //   fit: BoxFit.fill,
              //   progressIndicatorBuilder: (___, __, _) => ShimmerPlaceholder(
              //       child: Container(
              //     height: 180.h,
              //     color: Colors.black,
              //   )),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
            ),
            SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Text(newsModel.title ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!),
                ))
          ]),
        ),
      ),
    );
  }
}
