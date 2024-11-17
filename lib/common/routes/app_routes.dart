import 'package:get/get.dart';
import 'package:hog_v2/presentation/Auth/controller/registeration_controller.dart';
import 'package:hog_v2/presentation/Auth/pages/login_page.dart';
import 'package:hog_v2/presentation/Auth/pages/register_page.dart';
import 'package:hog_v2/presentation/course_details/controller/course_details_binding.dart';
import 'package:hog_v2/presentation/course_details/controller/show_lesson_binding.dart';
import 'package:hog_v2/presentation/course_details/pages/course_details_page.dart';
import 'package:hog_v2/presentation/course_details/widgets/show_course_video.dart';
import 'package:hog_v2/presentation/mainpage/controller/main_page_binding.dart';
import 'package:hog_v2/presentation/mainpage/pages/main_page.dart';
import 'package:hog_v2/presentation/onboarding/controllers/onboarding_controller.dart';
import 'package:hog_v2/presentation/onboarding/pages/on_boarding_page.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:hog_v2/presentation/quizzes/pages/quiz_page.dart';
import 'package:hog_v2/presentation/quizzes/pages/quizz_statistic_page.dart';
import 'package:hog_v2/presentation/search/controller/search_controller.dart';
import 'package:hog_v2/presentation/search/page/search_page.dart';
import 'package:hog_v2/presentation/settings/controller/setting_controller.dart';
import 'package:hog_v2/presentation/settings/pages/about_us_page.dart';
import 'package:hog_v2/presentation/settings/pages/privacy_policy_dart.dart';
import 'package:hog_v2/presentation/settings/pages/settings_page.dart';
import 'package:hog_v2/presentation/userinfo/page/user_info_page.dart';
import 'package:hog_v2/presentation/yearcoursespage/page/year_courses_page.dart';

class AppRoute {
  static String onboardingPageRoute = '/onboarding';
  static String loginPageRoute = '/login';
  static String registerPageRoute = '/register';
  static String userInfoPageRoute = '/userinfo';
  static String yearsPageRoute = '/years_page';
  static String settingsPageRoute = '/settings';
  static String aboutUsPageRoute = "/about_us";
  static String mainPageRoute = "/main_page";
  static String myProfilePageRoute = "/profile_page";
  static String courseDetailsPageRoute = "/course_detail";
  static String showCourseVideoRoute = '/show_CourseVideo';
  static String showCoursePdfRoute = '/show_course_pdf';
  static String quizStatisiticPageRoute = '/show_statistics_page';
  static String quizzPageRoute = '/quizz_page';
  static String quizResultPageRoute = '/quiz_result_page';
  static String searchPageRoute = '/search_page';
  static String privacyPolicyRoute = '/privacy_policy';
  static String downloadedVideosRoute = '/downloaded_videos';

  static List<GetPage> pages = [
    GetPage(
      name: onboardingPageRoute,
      page: () => const OnBoardingPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => OnBoardingPageController());
        },
      ),
    ),
    GetPage(
      name: loginPageRoute,
      page: () => const LoginPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => RegisterationController());
        },
      ),
    ),
    GetPage(
      name: registerPageRoute,
      page: () => const RegisterPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => RegisterationController());
        },
      ),
    ),
    GetPage(name: userInfoPageRoute, page: () => const UserInfoPage()),
    GetPage(
      name: settingsPageRoute,
      page: () => const SettingsPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => SettingController());
        },
      ),
    ),
    GetPage(name: aboutUsPageRoute, page: () => const AboutUsPage()),

    GetPage(
      name: mainPageRoute,
      page: () => const MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(name: yearsPageRoute, page: () => const YearsCoursesPage()),
    GetPage(
        name: courseDetailsPageRoute,
        page: () => const CourseDetailsPage(),
        binding: CourseDetailsBinding()),
    GetPage(
        name: showCourseVideoRoute,
        page: () => const ShowCourseVideo(),
        binding: ShowLessonBinding()),
    // GetPage(name: showCourseVideoRoute, page: () => const ShowCourseVideo()),
    GetPage(name: quizStatisiticPageRoute, page: () => const QuizStatisticPage()),
    GetPage(
      name: quizzPageRoute,
      page: () => const QuizzesPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => QuizController());
        },
      ),
    ),
    // GetPage(name: quizResultPageRoute, page: () => ResultPage()),
    GetPage(
      name: searchPageRoute,
      page: () => const SearchPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => SearchPageController());
        },
      ),
    ),
    GetPage(name: privacyPolicyRoute, page: () => const PricyPolicy()),

    // GetPage(
    // name: downloadedVideosRoute, page: () => const DownloadedVideosPage()),
  ];
}
