import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/screens/member_screen.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import '../../commonWidgits/custom_btn.dart';
import '../../controllers/setting_controller.dart';
import '../../utils/color_utils.dart';

class ParivarScreen extends StatefulWidget {
  final String villageId;
  final String tadId;
  final String tadName;

  const ParivarScreen({
    super.key,
    required this.villageId,
    required this.tadId,
    required this.tadName,
  });

  @override
  State<ParivarScreen> createState() => _ParivarScreenState();
}

class _ParivarScreenState extends State<ParivarScreen> {
  final controller = Get.find<SettingController>();

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  void initMethod() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.loadParivars(widget.villageId, widget.tadId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          widget.tadName,
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
                        text: "Add Parivar",
                        icon: Icons.add,
                        fontSize: 10.sp,
                        onPressed: () => controller.showAddDialog(
                          context: context,
                          title: 'Parivar',
                          onSubmit: (value) => controller.addParivar(
                            widget.villageId,
                            widget.tadId,
                            value,
                          ),
                        ),
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Colors.transparent,
                        borderRadius: 10.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    controller.parivars.isEmpty
                        ? CustomText(
                            "No parivars added yet.",
                            color: Colors.grey,
                            fontSize: 10.sp,
                          )
                        : Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: controller.parivars
                                .map(
                                  (parivar) => InkWell(
                                    onTap: () {
                                      final parivarName = parivar['name'];
                                      final villageId = widget.villageId;
                                      final tadId = widget.tadId;
                                      final parivarId = parivar['docId'];

                                      print(
                                        "🟢 Navigating to MemberScreen with:",
                                      );
                                      print("   Parivar Name: $parivarName");
                                      print("   Village ID  : $villageId");
                                      print("   Tad ID      : $tadId");
                                      print("   Parivar ID  : $parivarId");

                                      Get.to(
                                        () => MemberScreen(
                                          parivarName: parivarName,
                                          villageId: villageId,
                                          tadId: tadId,
                                          parivarId: parivarId,
                                        ),
                                      );
                                    },
                                    child: Chip(
                                      label: CustomText(
                                        parivar['name'],
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
