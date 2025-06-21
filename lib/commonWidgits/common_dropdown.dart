import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';

class CommonDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontUtils.cerebriSans,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: CustomText(
                item,
                fontWeight: FontWeight.w400,
                fontSize: 8.sp,
              ),
            ),
          )
          .toList(),
    );
  }
}
