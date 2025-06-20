import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:web_app_demo/utils/color_utils.dart';

import '../utils/Theme/app_text_style.dart';

// class CustomBtn extends StatelessWidget {
//   final VoidCallback? onTap;
//   final String? title;
//   final double? radius;
//   final double? verticalPadding;
//   final double? height;
//   final double? width;
//   final Color? bgColor;
//   final Color? textColor;
//   final Color? borderColor;
//   final double? fontSize;
//   final bool? boxShadow;
//
//   // ignore: use_key_in_widget_constructors
//   const CustomBtn({
//     required this.onTap,
//     required this.title,
//     this.radius,
//     this.borderColor,
//     this.height,
//     this.width,
//     this.verticalPadding,
//     this.fontSize,
//     this.bgColor,
//     this.textColor,
//     this.boxShadow = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Container(
//       width: width ?? Get.width,
//       decoration: BoxDecoration(
//         color: bgColor ?? theme.primaryColor,
//         border: Border.all(color: borderColor ?? theme.primaryColor),
//         borderRadius: BorderRadius.circular(radius ?? 5.r),
//         boxShadow: boxShadow == true
//             ? [
//                 BoxShadow(
//                   color: ColorUtils.buttonShadowColor,
//                   offset: const Offset(0, 4),
//                   blurRadius: 12,
//                 ),
//               ]
//             : null,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(radius ?? 5.r),
//           onTap: onTap,
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 14.w),
//             child: Center(
//               child: CustomText(
//                 title!,
//                 fontWeight: FontWeight.w600,
//                 color: textColor ?? ColorUtils.white,
//                 fontSize: fontSize ?? 17.sp,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? size;
  final bool isDisabled;
  final double? width; // Add this

  const CustomBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.fontSize,
    this.fontColor,
    this.size,
    this.fontWeight,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          height: 45.h,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: size ?? 14.sp,
                    color: fontColor ?? Colors.white,
                  ),
                if (icon != null) SizedBox(width: 4.w),
                CustomText(
                  text,
                  fontSize: fontSize ?? 10.sp,
                  color: fontColor ?? Colors.white,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
