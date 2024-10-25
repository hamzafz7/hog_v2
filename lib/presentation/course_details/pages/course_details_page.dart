import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';
import 'package:hog_v2/presentation/course_details/widgets/course_curriculum.dart';
import 'package:hog_v2/presentation/course_details/widgets/course_describtion.dart';
import 'package:hog_v2/presentation/course_details/widgets/course_details_header.dart';
import 'package:hog_v2/presentation/course_details/widgets/custom_shape.dart';
import 'package:hog_v2/presentation/course_details/widgets/custom_tap_bar.dart';
import 'package:hog_v2/presentation/custom_dialogs/code_activate_dialog.dart';
import 'package:hog_v2/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:hog_v2/presentation/widgets/custom_button.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseDetailsController>();

    bool isCourseAccessible(CourseDetailsController controller) {
      final course = controller.courseInfoModel?.course;
      return course != null &&
          (course.isOpen == true ||
              course.isPaid == true ||
              course.isTeachWithCourse == true ||
              GetIt.instance<CacheProvider>().getUserType() == 'admin');
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SizedBox(
          width: Get.width,
          child: Obx(
            () => switch (courseController.getCourseInfoStatus.value) {
              RequestStatus.success => Form(
                  key: courseController.courseDetailFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipPath(
                          clipper: ContainerCustomClipper(),
                          child: CourseDetailsHeader(
                            text: courseController.courseInfoModel!.course!.name,
                            image: courseController.courseInfoModel!.course!.image,
                          ),
                        ),
                        CustomTapBar(),
                        Obx(
                          () => IndexedStack(
                            index: courseController.currentTabIndex.value,
                            children: [
                              CourseDescribtionWidget(),
                              CourseCurriculum(),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: CustomButton(
                            onTap: () {
                              if (courseController.courseInfoModel?.course != null) {
                                if (!isCourseAccessible(courseController)) {
                                  CustomDialog(
                                    context,
                                    child: CodeActivationWidget(
                                      controller: courseController.activationController,
                                      onValidate: (val) =>
                                          GetIt.instance<Utils>().isFeildValidated(val),
                                      onTap: () async {
                                        try {
                                          if (courseController.courseDetailFormKey.currentState!
                                              .validate()) {
                                            await courseController.signInCourse(
                                              courseController.courseInfoModel!.course!.id!,
                                              courseController.activationController.text,
                                            );
                                          }
                                        } catch (e) {
                                          Get.snackbar("Error", "Failed to sign in: $e");
                                        }
                                      },
                                    ),
                                    height: 380,
                                  );
                                } else {
                                  courseController.changeCurrentWidgetIndx(1);
                                }
                              }
                            },
                            height: 50.h,
                            width: 382.w,
                            borderRadius: 17.r,
                            child: Obx(() {
                              return courseController.signInCourseStatus.value ==
                                      RequestStatus.loading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      isCourseAccessible(courseController)
                                          ? "تابع المشاهدة"
                                          : "ٍسجل الآن",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18.sp, color: Colors.white),
                                    );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              RequestStatus.begin => Container(),
              RequestStatus.loading => Center(child: appCircularProgress()),
              RequestStatus.onError => const Center(child: Text("حدث خطأ")),
              RequestStatus.noData => const Center(child: Text("لا يوجد بيانات")),
              RequestStatus.noInternentt => Container(),
            },
          ),
        ),
      ),
    );
  }
}
