import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:web_app_demo/commonWidgits/custom_btn.dart';
import 'package:web_app_demo/commonWidgits/custom_text_field.dart';
import 'package:web_app_demo/controllers/setting_controller.dart';
import 'package:web_app_demo/screens/login_page.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/string_utils.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          StringUtils.settings,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => LoginPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSection("Village", controller.villages, context),
              buildSection("Tad", controller.tads, context),
              buildSection("Parivar", controller.parivars, context),
            ],
          ),
        ),
      ),
    );
  }

  void showAddDialog(BuildContext context, String title) {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: CustomText(
          'Enter $title name',
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
        content: CommonTextField(
          controller: textController,
          label: 'Enter $title name',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomBtn(
                onPressed: () => Get.back(),
                text: 'Cancel',
                width: 80.w,
                backgroundColor: Colors.grey.shade500,
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                borderRadius: 8.r,
              ),
              SizedBox(width: 12.w),
              CustomBtn(
                onPressed: () {
                  final value = textController.text.trim();
                  if (value.isNotEmpty) {
                    controller.addItem(title, value);
                    Get.back();
                  }
                },
                text: 'OK',
                width: 80.w,
                backgroundColor: Theme.of(context).primaryColor,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
                borderRadius: 8.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSection(
    String title,
    RxList<String> items,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CustomBtn(
            width: 90.w,
            text: "Add $title",
            icon: Icons.add,
            fontSize: 8.sp,
            onPressed: () => showAddDialog(context, title),
            fontColor: Colors.white,
            fontWeight: FontWeight.bold,
            backgroundColor: Theme.of(context).primaryColor,
            borderColor: Colors.white,
            borderRadius: 8.r,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() {
          if (items.isEmpty) {
            return CustomText(
              "No $title added yet.",
              color: Colors.grey,
              fontSize: 9.sp,
            );
          } else {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items
                  .map(
                    (item) => Chip(
                      label: CustomText(item, fontSize: 8.sp),
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withOpacity(0.1),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                  .toList(),
            );
          }
        }),
        SizedBox(height: 25.h),
      ],
    );
  }
}
