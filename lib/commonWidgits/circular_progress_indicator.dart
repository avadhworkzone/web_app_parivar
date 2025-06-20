import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/utils/color_utils.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key, this.isExpand = false, this.bgColor});
  final bool? isExpand;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isExpand == false ? 35.w : Get.height,
      width: isExpand == false ? 35.w : Get.width,
      color: bgColor ?? Colors.white.withValues(alpha: 0.5),

      child: const Center(
        child: CircularProgressIndicator(color: ColorUtils.primary),
      ),
    );
  }
}
