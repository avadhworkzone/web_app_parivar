// 📁 screens/tad_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/screens/parivar_screen.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import '../../commonWidgits/custom_btn.dart';
import '../../controllers/setting_controller.dart';
import '../../utils/color_utils.dart';

class TadScreen extends StatefulWidget {
  final String villageId;
  final String villageName;
  final String villageDocId;

  const TadScreen({
    super.key,
    required this.villageId,
    required this.villageName,
    required this.villageDocId,
  });

  @override
  State<TadScreen> createState() => _TadScreenState();
}

class _TadScreenState extends State<TadScreen> {
  final controller = Get.find<SettingController>();

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  void initMethod() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.loadTads(widget.villageDocId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          widget.villageName,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
        centerTitle: true,
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
                        text: "Add Tad",
                        icon: Icons.add,
                        fontSize: 10.sp,
                        onPressed: () => controller.showAddDialog(
                          context: context,
                          title: 'Tad',
                          onSubmit: (value) =>
                              controller.addTad(widget.villageDocId, value),
                        ),
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Colors.transparent,
                        borderRadius: 10.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    controller.tads.isEmpty
                        ? CustomText(
                            "No tads added yet.",
                            color: Colors.grey,
                            fontSize: 10.sp,
                          )
                        : Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: controller.tads
                                .map(
                                  (tad) => InkWell(
                                    onTap: () {
                                      print(
                                        "🟢 Tapped Tad - ID: ${tad['docId']}, Name: ${tad['name']}",
                                      );
                                      Get.to(
                                        () => ParivarScreen(
                                          villageId: widget.villageDocId,
                                          tadId: tad['docId'],
                                          tadName: tad['name'],
                                        ),
                                      );
                                    },
                                    child: Chip(
                                      label: CustomText(
                                        tad['name'],
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
