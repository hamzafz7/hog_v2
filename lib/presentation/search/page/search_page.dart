import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/presentation/homepage/widgets/home_course_item.dart';
import 'package:hog_v2/presentation/search/controller/search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageController controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    controller = Get.find<SearchPageController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: 400), () {
          if (mounted) {
            FocusScope.of(context).requestFocus(FocusNode());
            focusNode.requestFocus();
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printError(info: 'SearchPage Build');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextFormField(
          focusNode: focusNode,
          enableInteractiveSelection: false,
          style: Theme.of(context).textTheme.bodyMedium,
          controller: controller.searchController,
          onChanged: (val) {
            if (controller.debounceTimer?.isActive ?? false) controller.debounceTimer?.cancel();
            if (val.isNotEmpty) {
              controller.debounceTimer = Timer(const Duration(milliseconds: 500), () async {
                controller.cancelToken.cancel("New search started");
                controller.cancelToken = CancelToken();
                if (kDebugMode) {
                  debugPrint('Request was cancelled');
                  debugPrint('Search again');
                }
                controller.searchCourse(val);
              });
            }
          },
          cursorColor: kprimaryBlueColor,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: kprimaryGreyColor,
              size: 40.r,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: '  ابحث عن ما تريد ما تريد من كوررسات..',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      body: GetBuilder<SearchPageController>(
        id: "SearchPage",
        builder: (_) => switch (controller.courseStatus) {
          RequestStatus.success => CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemBuilder: (context, index) {
                    final course = controller.coursesModel?.courses?[index];
                    return course != null ? HomeCourseItem(courseModel: course) : SizedBox.shrink();
                  },
                  itemCount: controller.coursesModel?.courses?.length ?? 0,
                ),
              ],
            ),
          RequestStatus.begin => SizedBox.shrink(),
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
                  ),
                ),
              ],
            ),
        },
      ),
      // ),
    );
  }
}
