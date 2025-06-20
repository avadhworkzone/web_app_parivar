import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';

// typedef OnChangeString = void Function(String value);
// typedef Validator = String? Function(String? value);
// typedef OnTap = void Function();
//
// typedef OnChangeDropDown = void Function(String? value);
//
// class CommonTextField extends StatelessWidget {
//   final TextEditingController? textEditController;
//   final String? initialValue;
//   final bool? isValidate;
//   final bool? readOnly;
//   final TextInputType? keyBoardType;
//   final Validator? validator;
//   final String? regularExpression;
//   final int? inputLength;
//   final String? hintText;
//   final String? labelText;
//   final String? validationMessage;
//   final String? preFixIconPath;
//   final int? maxLine;
//   final Widget? sIcon;
//   final Widget? pIcon;
//   final Widget? suffix;
//   final bool? obscureValue;
//   final bool? underLineBorder;
//   final bool? showLabel;
//   final bool? isDropdown;
//   final bool hasError;
//   final int? maxLength;
//   final String? errorMessage;
//   final OnChangeString? onChange;
//   final OnTap? onTap;
//   final Color? borderColor;
//   final Widget? counter;
//   final FocusNode? focusNode;
//   final bool? contentPadding;
//   final bool textCapitalization;
//   final bool autoFocus;
//   final double? fontSize;
//   final String? counterText;
//
//   const CommonTextField({
//     super.key,
//     this.regularExpression = '',
//     this.textEditController,
//     this.isValidate = true,
//     this.keyBoardType,
//     this.inputLength,
//     this.readOnly = false,
//     this.underLineBorder = false,
//     this.showLabel = false,
//     this.isDropdown = false,
//     this.hintText,
//     this.validationMessage,
//     this.maxLine,
//     this.sIcon,
//     this.pIcon,
//     this.preFixIconPath,
//     this.onChange,
//     this.initialValue = '',
//     this.obscureValue,
//     this.labelText,
//     this.hasError = false,
//     this.errorMessage,
//     this.onTap,
//     this.borderColor,
//     this.contentPadding = false,
//     this.textCapitalization = false,
//     this.validator,
//     this.suffix,
//     this.maxLength,
//     this.autoFocus = false,
//     this.focusNode,
//     this.counter,
//     this.fontSize,
//     this.counterText,
//   });
//
//   /// PLEASE IMPORT GET X PACKAGE
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: TextFormField(
//         focusNode: focusNode,
//         textCapitalization: textCapitalization
//             ? TextCapitalization.characters
//             : TextCapitalization.none,
//         controller: textEditController,
//         autofocus: autoFocus,
//         style: TextStyle(
//           color: ColorUtils.black21,
//           fontSize: fontSize ?? 16.sp,
//           fontWeight: FontWeight.w500,
//           fontFamily: FontUtils.cerebriSans,
//         ),
//         keyboardType: keyBoardType ?? TextInputType.text,
//         maxLines: maxLine ?? 1,
//         maxLength: maxLength,
//         inputFormatters: regularExpression!.isEmpty || regularExpression == ""
//             ? [
//                 LengthLimitingTextInputFormatter(inputLength),
//                 NoLeadingSpaceFormatter(),
//               ]
//             : [
//                 LengthLimitingTextInputFormatter(inputLength),
//                 FilteringTextInputFormatter.allow(RegExp(regularExpression!)),
//                 NoLeadingSpaceFormatter(),
//               ],
//         onTap: onTap,
//         onChanged: onChange,
//         // enabled: !readOnly!,
//         readOnly: readOnly!,
//         validator: validator,
//         textInputAction: TextInputAction.done,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         cursorColor: ColorUtils.black21,
//         decoration: InputDecoration(
//           counterText: counterText,
//           counterStyle: TextStyle(
//             color: ColorUtils.grey55,
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w500,
//           ),
//           contentPadding: EdgeInsets.zero,
//           fillColor: Colors.transparent,
//           counter: counter,
//           filled: true,
//           labelText: (labelText?.isNotEmpty ?? false)
//               ? labelText.toString().tr
//               : "",
//           labelStyle: TextStyle(
//             color: ColorUtils.grey99,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: FontUtils.cerebriSans,
//           ),
//           enabledBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorUtils.primary,
//             ), // Change the bottom border color here
//           ),
//           focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorUtils.primary,
//             ), // Change the bottom border color here
//           ),
//           errorStyle: TextStyle(
//             color: ColorUtils.red,
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: FontUtils.cerebriSans,
//           ),
//           errorBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorUtils.red,
//             ), // Change the bottom border color here
//           ),
//           focusedErrorBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorUtils.red,
//             ), // Change the bottom border color here
//           ),
//           disabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: borderColor ?? Colors.transparent,
//             ), // Change the bottom border color here
//           ),
//           errorText: hasError ? errorMessage : null,
//           suffixIcon: sIcon,
//           prefixIcon: pIcon,
//           suffix: suffix,
//           // hintText: showLabel! ? '' : hintText.toString().tr,
//           // hintStyle: TextStyle(
//           //     color: ColorUtils.grey,
//           //     fontSize: 17.sp,
//           //     fontFamily: FontUtils.cerebriSans),
//         ),
//       ),
//     );
//   }
// }
//
// class NoLeadingSpaceFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.startsWith(' ')) {
//       final String trimedText = newValue.text.trimLeft();
//
//       return TextEditingValue(
//         text: trimedText,
//         selection: TextSelection(
//           baseOffset: trimedText.length,
//           extentOffset: trimedText.length,
//         ),
//       );
//     }
//
//     return newValue;
//   }
// }
//
// class DropDownTextField extends StatelessWidget {
//   const DropDownTextField({
//     super.key,
//     this.onChangeDropDown,
//     required this.itemList,
//     required,
//     required this.labelText,
//     this.value,
//     this.validator,
//     this.dropdownIcon,
//   });
//
//   final OnChangeDropDown? onChangeDropDown;
//   final List<String> itemList;
//   final String labelText;
//   final String? value;
//   final Validator? validator;
//   final Widget? dropdownIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         label: CustomText(labelText, color: ColorUtils.grey99, fontSize: 16.sp),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: ColorUtils.greyF0),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: ColorUtils.greyF0),
//         ),
//         border: UnderlineInputBorder(
//           borderSide: BorderSide(color: ColorUtils.greyF0),
//         ),
//       ),
//       icon: Padding(
//         padding: EdgeInsets.only(right: 4.w),
//         child: dropdownIcon ?? Icon(Icons.arrow_drop_down, color: Colors.black),
//       ),
//       value: value,
//       // ▼ icon
//       isExpanded: true,
//       // optional: full width
//       items: itemList.map((state) {
//         return DropdownMenuItem(
//           value: state,
//           child: CustomText(state, color: ColorUtils.black21, fontSize: 16.sp),
//         );
//       }).toList(),
//       style: TextStyle(
//         color: ColorUtils.black21,
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w500,
//         fontFamily: FontUtils.cerebriSans,
//       ),
//       onChanged: onChangeDropDown,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 10.sp, fontFamily: FontUtils.cerebriSans),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontUtils.cerebriSans,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }
}
