import 'package:get/get.dart';
import 'package:hog_v2/presentation/course_details/controller/show_lesson_controller.dart';

class ShowLessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowLessonController>(() => ShowLessonController());
  }
}
