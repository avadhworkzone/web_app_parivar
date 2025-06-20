import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/utils/color_utils.dart';

class CommonDividerWithShadow extends StatelessWidget {
  const CommonDividerWithShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 1, width: Get.width, color: ColorUtils.greyEE),
        Container(
          height: 6.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorUtils.greyF6,
            boxShadow: [
              BoxShadow(
                color: ColorUtils.createPinShadowColor,
                offset: const Offset(0, -1),
                blurRadius: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
