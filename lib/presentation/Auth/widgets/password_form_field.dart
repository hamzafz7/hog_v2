import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:svg_flutter/svg.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.svgSrc,
    this.validator,
    this.hintText,
    required this.controller,
  });

  final String svgSrc;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController controller;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.w,
      decoration: ShapeDecoration(
        color: klightGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 8.w),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: !_isPasswordVisible,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 18.sp, color: kDarkBlueColor),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: kprimaryGreyColor,
              ),
              onPressed: _togglePasswordVisibility,
              // Improve touch target size
              padding: EdgeInsets.all(12.r),
              constraints: BoxConstraints(
                minHeight: 48.h,
                minWidth: 48.w,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kprimaryGreyColor),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.0.r),
              child: SvgPicture.asset(
                widget.svgSrc,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
