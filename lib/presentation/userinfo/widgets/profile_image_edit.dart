import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/profile/controllers/profile_controller.dart';
import 'package:hog_v2/presentation/profile/widgets/my_profile_image.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileImageEdit extends GetView<MyProfileController> {
  const ProfileImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(height: 125.h, child: const MyProfileImage()),
          IconButton(
              onPressed: () {
                if (!controller.isEdited.value) {
                  controller.changeIsEdit();
                }
                controller.getImagePicked();
              },
              icon: Container(
                width: 31.w,
                height: 31.h,
                decoration: const ShapeDecoration(
                  color: kprimaryBlueColor,
                  shape: OvalBorder(),
                ),
                child: SvgPicture.asset("assets/icons/edit.svg"),
              ))
        ],
      ),
    );
  }
}
