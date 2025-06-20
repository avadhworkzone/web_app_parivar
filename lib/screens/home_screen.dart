import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/screens/login_page.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/string_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          StringUtils.home,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: CustomText("${StringUtils.welcome}, ${user?.email ?? 'User'}"),
      ),
    );
  }
}
