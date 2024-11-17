import 'package:get/get.dart';
import 'package:hog_v2/presentation/controllers/themeController.dart';
import 'package:hog_v2/presentation/homepage/controller/home_controller.dart';
import 'package:hog_v2/presentation/mainpage/controller/main_page_controller.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainPageController(), permanent: true);
    Get.put(MyProfileController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(ThemeController(), permanent: true);
  }
}
