import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/categories_model.dart';
import 'package:hog_v2/presentation/homepage/controller/home_controller.dart';

class YearButton extends GetView<HomeController> {
  const YearButton({
    super.key,
    required this.index,
    required this.onPressed,
    required this.categoryModel,
  });
  final int index;
  final CategoryModel categoryModel;
  final Function()? onPressed;
  // final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: GetBuilder<HomeController>(
        id: "changeCurrentIndex_$index",
        builder: (_) => Container(
          width: 146.w,
          height: 70.h,
          decoration: ShapeDecoration(
            color: index == controller.currentCategoryIndex ? kprimaryBlueColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: kprimaryBlueColor),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Text(
                categoryModel.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: controller.currentCategoryIndex == index
                        ? Colors.white
                        : kprimaryBlueColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
