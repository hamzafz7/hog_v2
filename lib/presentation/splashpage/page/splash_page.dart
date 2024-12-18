import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/splashpage/controller/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );

    // Fade In Animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Slide Animation for Text
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation
    _controller.forward();
    Get.put(SplashPageController());
  }

  Future<bool> _isRealDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.isPhysicalDevice;
    } else {
      return false;
    }
  }

  // @override
  // void didChangeDependencies() async {
  //   String token1 =
  //       await GetIt.instance<CacheProvider>().createUUID(phone: '0999999998', context: context);
  //   String token2 =
  //       await GetIt.instance<CacheProvider>().createUUID(phone: '0999999998', context: context);
  //   if (kDebugMode) {
  //     print("token1 : $token1");
  //     print("token2 : $token2");
  //     print("token2 == token1 : ${token2 == token1}");
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _isRealDevice(),
          builder: (context, snapshot) => SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 130.h),

                    // Image Fade-In Animation
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Image.asset("assets/images/logo.png"),
                    ),

                    SizedBox(height: 20.h),

                    // Text Slide Animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        "House Of",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        "Geniuses",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Underline animation (you can animate this further if needed)
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Container(
                        width: 63.w,
                        height: 2.h,
                        color: ksecondaryColor,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Another Slide Transition for Arabic Text
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        "التعلم والمهارة والإبداع هدفك",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black.withOpacity(0.61),
                            ),
                      ),
                    ),

                    SizedBox(height: 59.h),
                  ],
                ),
              )),
    );
  }
}
