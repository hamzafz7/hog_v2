import 'package:get/get.dart';
import 'package:hog_v2/presentation/mainpage/controller/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
