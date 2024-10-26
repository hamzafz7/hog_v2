import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/common/constants/constants.dart';
import 'package:hog_v2/common/constants/enums/request_enum.dart';
import 'package:hog_v2/common/utils/utils.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';
import 'package:hog_v2/presentation/userinfo/widgets/profile_image_edit.dart';
import 'package:hog_v2/presentation/userinfo/widgets/profile_text_feild.dart';
import 'package:hog_v2/presentation/widgets/custom_appbar.dart';

class UserInfoPage extends GetView<MyProfileController> {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "الملف الشخصي",
        onPressed: () {
          controller.isEdited.value = false;
          controller.imagePicked.value = "";
          Get.back();
        },
      ),
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 20.h,
            ),
            const ProfileImageEdit(),
            Text(GetIt.instance<CacheProvider>().getUserName() ?? "لا يوجد",
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                children: [
                  Text('المعلومات الشخصية', style: Theme.of(context).textTheme.labelMedium!),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (controller.isEdited.value) {
                        controller.changeIsEdit();
                        controller.updateProfile();
                      } else {
                        controller.changeIsEdit();
                      }
                    },
                    child: GetBuilder<MyProfileController>(
                      builder: (_) => controller.updateProfileStatus == RequestStatus.loading
                          ? appCircularProgress()
                          : Text(!controller.isEdited.value ? 'تعديل' : 'حفظ',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14.sp,
                                  color: kprimaryBlueColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kprimaryBlueColor)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Obx(
              () => ProfileTextFeild(
                  isEdited: controller.isEdited.value,
                  titleText: "الاسم الكامل",
                  controller: controller.nameController,
                  onValidate: (val) {
                    return GetIt.instance<Utils>().isFeildValidated(val?.trim());
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => ProfileTextFeild(
                  isEdited: controller.isEdited.value,
                  titleText: "رقم الهاتف",
                  controller: controller.phoneController,
                  onValidate: (val) {
                    return GetIt.instance<Utils>().isPhoneValidated(val?.trim());
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Obx(
            //   () => ProfileTextFeild(
            //       isEdited: controller.isEdited.value,
            //       titleText: "العنوان",
            //       controller: controller.addressController,
            //       onValidate: (val) {
            //         return null;
            //       }),
            // )
          ]),
        ),
      ),
    );
  }
}
