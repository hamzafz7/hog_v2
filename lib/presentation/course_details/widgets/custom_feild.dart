import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hog_v2/common/constants/colors.dart';

class CustomActivationFeild extends StatelessWidget {
  const CustomActivationFeild(
      {super.key,
      required this.text,
      required this.controller,
      this.feildHeight,
      required this.onValidate,
      this.action = TextInputAction.next,
      this.svgUrl,
      this.textInputType = TextInputType.name});

  final String text;
  final TextEditingController controller;
  final String? Function(String?)? onValidate;
  final String? svgUrl;
  final TextInputType textInputType;
  final double? feildHeight;
  final TextInputAction action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: feildHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormFieldCustom(
          feildHeight: feildHeight,
          textInputType: textInputType,
          controller: controller,
          onValidate: onValidate,
          text: text,
        ),
      ),
    );
  }
}

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    super.key,
    required this.feildHeight,
    required this.textInputType,
    required this.controller,
    required this.onValidate,
    required this.text,
  });

  final double? feildHeight;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String? Function(String? p1)? onValidate;
  final String text;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      style: TextStyle(fontSize: 14.sp, color: kDarkBlueColor),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.newline,
      maxLines: widget.feildHeight == null ? 1 : null,
      minLines: widget.feildHeight == null ? 1 : null,
      expands: widget.feildHeight == null ? false : true,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.onValidate,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 220, 220),
              ),
              borderRadius: BorderRadius.circular(8.r)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: kprimaryBlueColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color.fromARGB(255, 221, 220, 220))),
          hintText: widget.text,
          hintStyle: TextStyle(fontSize: 12.sp)),
    );
  }
}
