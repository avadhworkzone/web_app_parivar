// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/commonWidgits/custom_btn.dart';
import 'package:web_app_demo/commonWidgits/custom_text_field.dart';
import 'package:web_app_demo/controllers/auth_controller.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import '../utils/string_utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(StringUtils.appName, fontSize: 13.sp),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 80.sp,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  StringUtils.welcome,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 30.h),
                CommonTextField(
                  controller: controller.emailController,
                  label: StringUtils.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val == null || !val.contains("@")
                      ? StringUtils.enterValidEmail
                      : null,
                ),
                SizedBox(height: 16.h),
                CommonTextField(
                  controller: controller.passwordController,
                  label: StringUtils.password,
                  obscureText: true,
                  validator: (val) => val != null && val.length < 6
                      ? StringUtils.minimumSixCharacters
                      : null,
                ),

                SizedBox(height: 30.h),
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            CustomBtn(
                              text: StringUtils.login,
                              icon: Icons.login,
                              onPressed: controller.login,
                            ),
                            SizedBox(height: 12.h),
                            CustomBtn(
                              text: StringUtils.register,
                              icon: Icons.app_registration,
                              // isOutlined: true,
                              onPressed: controller.register,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
