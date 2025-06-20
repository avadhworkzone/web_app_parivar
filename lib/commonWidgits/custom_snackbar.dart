import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:web_app_demo/utils/color_utils.dart';

import '../utils/Theme/app_text_style.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  bool isSuccess = false,
}) {
  final overlay = Overlay.of(context);
  final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

  final animationController = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 500),
  );

  final animation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
      .animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: appBarHeight, // Below AppBar
      // left: 16,
      // right: 16,
      child: SlideTransition(
        position: animation,
        child: GestureDetector(
          onTap: () async {
            await animationController.reverse();
            overlayEntry.remove();
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSuccess ? ColorUtils.primary : ColorUtils.red,
                // borderRadius: BorderRadius.circular(10),
              ),
              child: CustomText(
                message,
                fontSize: 16.sp,
                color: ColorUtils.white,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  animationController.forward();

  Future.delayed(Duration(seconds: 2), () async {
    if (overlayEntry.mounted) {
      await animationController.reverse();
      overlayEntry.remove();
    }
  });
}
