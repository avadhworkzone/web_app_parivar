import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/commonWidgits/common_assets.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';

class CommonSearchFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? isPrefixVisible;
  final bool? isFromPhoneBook;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CommonSearchFiled({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.isPrefixVisible,
    this.isFromPhoneBook,
  });

  @override
  _CommonSearchFiledState createState() => _CommonSearchFiledState();
}

class _CommonSearchFiledState extends State<CommonSearchFiled> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorUtils.searchFilledShadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _controller,
        style: TextStyle(color: ColorUtils.black21, fontSize: 16.sp),
        decoration: InputDecoration(
          fillColor: ColorUtils.white,
          filled: true,
          hintText: widget.hintText != null
              ? widget.hintText?.tr
              : widget.hintText,
          prefixIcon: (widget.isPrefixVisible ?? false)
              ? widget.prefixIcon ??
                    LocalAssets(
                      scaleSize: 6,
                      imgColor: ColorUtils.greyB8,
                      imagePath: IconUtils.searchIcon,
                    )
              : null,
          prefixIconConstraints: BoxConstraints.tight(Size(50, 30)),
          suffixIcon: (widget.isFromPhoneBook ?? false)
              ? widget.suffixIcon
              : _controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                    setState(() {}); // Refresh UI when cleared
                    if (widget.onChanged != null) {
                      widget.onChanged!(""); // Notify parent widget
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: ColorUtils.primary,
                      shape: BoxShape.circle,
                    ),
                    child:
                        widget.suffixIcon ??
                        LocalAssets(
                          height: 14.w,
                          width: 14.w,
                          imgColor: ColorUtils.white,
                          imagePath: IconUtils.clear,
                        ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: ColorUtils.greyEE),
          ),
          hintStyle: TextStyle(color: ColorUtils.grey99),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: ColorUtils.greyEE),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: ColorUtils.greyEE),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: ColorUtils.grey4B),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
        onChanged: (text) {
          setState(() {}); // Update UI when text changes
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
      ),
    );
  }
}
