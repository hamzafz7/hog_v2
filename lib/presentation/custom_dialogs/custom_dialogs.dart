import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom dialog function with options for customization
Future<T?> customDialog<T>(
  BuildContext context, {
  required Widget child,
  double height = 350,
  double width = 374,
  bool barrierDismissible = true, // Allows dismissal by tapping outside
  Color? backgroundColor = Colors.white,
  ShapeBorder? shape, // Custom shape for the dialog
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible, // Controls if tapping outside will close the dialog
    builder: (context) => Dialog(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Default rounded shape
          ),
      backgroundColor: backgroundColor,
      child: SizedBox(
        height: height.h,
        width: width.w,
        child: child,
      ),
    ),
  );
}
