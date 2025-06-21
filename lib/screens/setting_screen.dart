import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:web_app_demo/commonWidgits/custom_btn.dart';
import 'package:web_app_demo/commonWidgits/custom_text_field.dart';
import 'package:web_app_demo/controllers/setting_controller.dart';
import 'package:web_app_demo/screens/login_page.dart';
import 'package:web_app_demo/screens/tad_screen.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/string_utils.dart';

//
// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});
//
//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//   final controller = Get.put(SettingController());
//
//   void showAddVillageDialog() {
//     final textController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: CustomText(
//           'Add Village',
//           fontWeight: FontWeight.bold,
//           fontSize: 12.sp,
//         ),
//         content: CommonTextField(
//           controller: textController,
//           label: 'Enter Village Name',
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CustomBtn(
//                 onPressed: () => Get.back(),
//                 text: 'Cancel',
//                 width: 80.w,
//                 backgroundColor: Colors.grey.shade400,
//                 fontColor: Colors.black,
//                 fontWeight: FontWeight.w600,
//                 borderRadius: 8.r,
//               ),
//               SizedBox(width: 12.w),
//               CustomBtn(
//                 onPressed: () async {
//                   final value = textController.text.trim();
//                   if (value.isNotEmpty) {
//                     Get.back(); // close dialog first
//                     await controller.addVillage(value);
//                   }
//                 },
//                 text: 'OK',
//                 width: 80.w,
//                 backgroundColor: Theme.of(context).primaryColor,
//                 fontColor: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 borderRadius: 8.r,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorUtils.white,
//       appBar: AppBar(
//         title: CustomText(
//           StringUtils.settings,
//           fontWeight: FontWeight.w700,
//           fontSize: 16.sp,
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Get.offAll(() => LoginPage());
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() {
//           return controller.isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: CustomBtn(
//                         width: 120.w,
//                         text: "Add Village",
//                         icon: Icons.add,
//                         fontSize: 10.sp,
//                         onPressed: showAddVillageDialog,
//                         fontColor: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         backgroundColor: Theme.of(context).primaryColor,
//                         borderColor: Colors.transparent,
//                         borderRadius: 10.r,
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     controller.villages.isEmpty
//                         ? CustomText(
//                             "No villages added yet.",
//                             color: Colors.grey,
//                             fontSize: 10.sp,
//                           )
//                         : Wrap(
//                             spacing: 10.w,
//                             runSpacing: 10.h,
//                             children: controller.villages
//                                 .map(
//                                   (village) => Chip(
//                                     label: CustomText(
//                                       "${village['name']}",
//                                       fontSize: 10.sp,
//                                     ),
//                                     backgroundColor: Theme.of(
//                                       context,
//                                     ).primaryColor.withOpacity(0.1),
//                                     labelStyle: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 )
//                                 .toList(),
//                           ),
//                   ],
//                 );
//         }),
//       ),
//     );
//   }
// }
// 📁 setting_screen.dart
class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          'Settings',
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
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
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomBtn(
                        width: 120.w,
                        text: "Add Village",
                        icon: Icons.add,
                        fontSize: 10.sp,
                        onPressed: () => controller.showAddDialog(
                          context: context,
                          title: 'Village',
                          onSubmit: (value) => controller.addVillage(value),
                        ),
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Colors.transparent,
                        borderRadius: 10.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    controller.villages.isEmpty
                        ? CustomText(
                            "No villages added yet.",
                            color: Colors.grey,
                            fontSize: 10.sp,
                          )
                        : Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: controller.villages
                                .map(
                                  (village) => InkWell(
                                    onTap: () => Get.to(
                                      () => TadScreen(
                                        villageId: village['id'],
                                        villageName: village['name'],
                                        villageDocId: village['docId'], // ✅ NEW
                                      ),
                                    ),
                                    child: Chip(
                                      label: CustomText(
                                        village['name'],
                                        fontSize: 10.sp,
                                      ),
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor.withOpacity(0.1),
                                      labelStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ],
                );
        }),
      ),
    );
  }
}
