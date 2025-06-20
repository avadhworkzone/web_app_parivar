import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/commonWidgits/common_assets.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';

import '../utils/color_utils.dart';

typedef ClickOnTap = Function();

AppBar commonAppBar(
    {required BuildContext context,
    VoidCallback? backPress,
    required String titleText,
    bool isBackButton = true,
    bool isNotificationButton = true}) {
  return AppBar(
    // toolbarHeight: 7.5.h,
    leading: const SizedBox(),
    leadingWidth: 0,
    title: Row(
      children: [
        if (isBackButton)
          InkWell(
              onTap: backPress ?? () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: Get.width >= 500 ? 4.w : 6.w,
              )),
        Padding(
          padding: EdgeInsets.only(left: Get.width >= 500 ? 1.w : 0),
          child: CustomText(
            titleText,
            fontSize: 17.8.sp,
          ),
        ),
      ],
    ),
    actions: [],
  );
}

AppBar customAppBar(
    {required String title, Widget? action, bool? isCloseIcon = false, bool? isMenuIcon = false, void Function()? onClosTap,Color? bgColor}) {
  return
    AppBar(
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
    leading: IconButton(
        onPressed: onClosTap ?? () {
          Get.back();
        },
        icon: isMenuIcon == true ? LocalAssets(
          imagePath: IconUtils.menu,
          width: 18.w,
          height: 22.h,
          imgColor: ColorUtils.black21,
        ) : Icon(
          isCloseIcon == true ? Icons.close :  Icons.arrow_back,
          color: ColorUtils.black21,
        )),
    title: CustomText(
      title,
      fontSize: 17.sp,
      color: ColorUtils.black21,
    ),
    centerTitle: true,
    actions: [if (action != null) action],
  );
}
