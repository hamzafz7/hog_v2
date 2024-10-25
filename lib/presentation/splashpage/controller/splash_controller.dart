import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (GetIt.instance<CacheProvider>().getIsOnBoardingOpened() == null) {
        Get.offAllNamed(AppRoute.onboardingPageRoute);
      } else if (await GetIt.instance<CacheProvider>().getAppToken() == null) {
        Get.offAllNamed(AppRoute.loginPageRoute);
      } else {
        Get.offAllNamed(AppRoute.mainPageRoute);
      }
    });
    super.onInit();
  }
}
