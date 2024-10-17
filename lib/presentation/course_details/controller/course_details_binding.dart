import 'package:get/get.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDetailsController());
  }
}
