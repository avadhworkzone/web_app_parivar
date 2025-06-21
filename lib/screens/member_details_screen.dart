import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';

import '../utils/string_utils.dart';

class MemberDetailScreen extends StatelessWidget {
  final Map<String, dynamic> member;

  const MemberDetailScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(member['name'], fontSize: 16.sp),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundImage: MemoryImage(base64Decode(member['imageBase64'])),
            ),
            SizedBox(height: 20.h),
            _infoRow(StringUtils.name, member['name']),
            _infoRow(StringUtils.age, member['age']),
            _infoRow(StringUtils.gender, member['gender']),
            _infoRow(StringUtils.education, member['education']),
            _infoRow(StringUtils.mobileNumber, member['mobile']),
            _infoRow(StringUtils.address, member['address']),
            _infoRow(StringUtils.vadaName, member['vadaName']),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              "$title:",
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          Expanded(child: CustomText(value ?? '-', fontSize: 12.sp)),
        ],
      ),
    );
  }
}
