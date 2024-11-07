import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/routes/app_routes.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/presentation/Auth/widgets/password_form_field.dart';
import 'package:hog_v2/presentation/Auth/widgets/regular_form_field.dart';
import 'package:hog_v2/presentation/widgets/custom_button.dart';

import '../controller/registeration_controller.dart';

class LoginPage extends GetView<RegisterationController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.loginPageFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                  height: 200.h, width: Get.width, child: Image.asset("assets/images/logo.png")),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    "تسجيل الدخول",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              RegularFormField(
                controller: controller.loginPhoneController,
                hintText: 'رقم الهاتف',
                svgSrc: "assets/icons/Phone1.svg",
                validator: (val) {
                  return GetIt.instance<Utils>().isPhoneFeildValidated(val?.trim());
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              PasswordFormField(
                controller: controller.loginPasswordController,
                hintText: 'كلمة المرور',
                svgSrc: "assets/icons/Lock.svg",
                validator: (val) {
                  return GetIt.instance<Utils>().isPasswordValidated(val?.trim());
                },
              ),
              SizedBox(
                height: 70.h,
              ),
              GetBuilder<RegisterationController>(
                builder: (_) => controller.loginState == RequestStatus.loading
                    ? appCircularProgress()
                    : CustomButton(
                        onTap: () {
                          controller.userLogin();
                        },
                        height: 55.h,
                        width: 333.w,
                        child: Text(
                          "تسجيل الدخول",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        ),
                      ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ليس لديك حساب ؟", style: Theme.of(context).textTheme.bodySmall),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.registerPageRoute);
                      },
                      child: Text("إنشاء حساب",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: kprimaryBlueColor,
                              decoration: TextDecoration.underline,
                              decorationColor: kprimaryBlueColor))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
