import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/presentation/homepage/widgets/home_course_item.dart';
import 'package:hog_v2/presentation/search/controller/search_controller.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Icon(
          Icons.search,
          color: kprimaryGreyColor,
          size: 40.r,
        ),
        title: TextFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          controller: controller.searchController,
          autofocus: true,
          onChanged: (val) async {
            if (controller.debounceTimer != null) controller.debounceTimer?.cancel();
            controller.debounceTimer = Timer(const Duration(milliseconds: 500), () async {
              if (val.isNotEmpty && controller.searchController.text.isNotEmpty) {
                controller.cancelToken.cancel();
                debugPrint('Request was cancelled');
                debugPrint('Search again');
                await controller.searchCourse(val);
              }
              if (val.isEmpty || controller.searchController.text.isEmpty) {
                controller.updatecourseStatus(RequestStatus.begin);
              }
            });
          },
          cursorColor: kprimaryBlueColor,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '  ابحث عن ما تريد ما تريد من كوررسات..',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      body: GetBuilder<SearchPageController>(
        builder: (_) => switch (controller.courseStatus) {
          RequestStatus.success => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
              ),
              itemCount: controller.coursesModel!.courses!.length,
              itemBuilder: (context, index) {
                return HomeCourseItem(
                  courseModel: controller.coursesModel!.courses![index],
                );
              },
            ),
          RequestStatus.begin => Container(),
          RequestStatus.loading => Column(
              children: [
                Expanded(
                  child: Center(child: appCircularProgress()),
                ),
              ],
            ),
          RequestStatus.onError => Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "حدث خطأ ما",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          RequestStatus.noData => Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "لا يوجد أي كورس بهذا الاسم",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          RequestStatus.noInternentt => Column(
              children: [
                Expanded(
                    child: Center(
                  child: Text(
                    "لا يوجد إتصال بلإنترنت",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
              ],
            ),
        },
      ),
    );
  }
}
