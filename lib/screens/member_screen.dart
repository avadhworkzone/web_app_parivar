import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/commonWidgits/common_dropdown.dart';
import 'package:web_app_demo/commonWidgits/custom_snackbar.dart';
import 'package:web_app_demo/controllers/members_controller.dart';
import 'package:web_app_demo/screens/member_details_screen.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/constants.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';
import 'package:web_app_demo/utils/string_utils.dart';
import '../../commonWidgits/custom_btn.dart';
import '../../commonWidgits/custom_text_field.dart';
import '../../utils/color_utils.dart';

class MemberScreen extends StatefulWidget {
  final String villageId;
  final String tadId;
  final String parivarId;
  final String parivarName;

  const MemberScreen({
    super.key,
    required this.villageId,
    required this.tadId,
    required this.parivarId,
    required this.parivarName,
  });

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final controller = Get.put(MemberController());

  @override
  void initState() {
    super.initState();
    controller.loadMembers(
      villageId: widget.villageId,
      tadId: widget.tadId,
      parivarId: widget.parivarId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: CustomText(
          widget.parivarName,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomBtn(
                        width: 140.w,
                        text: StringUtils.addMember,
                        icon: Icons.person_add,
                        fontSize: 10.sp,
                        onPressed: showAddMemberDialog,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (controller.members.isEmpty) {
                        return Center(
                          child: CustomText(
                            StringUtils.noMembersAddedYet,
                            color: Colors.grey,
                          ),
                        );
                      }
                      return Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 2;
                            double width = constraints.maxWidth;

                            if (width > 1200) {
                              crossAxisCount = 5;
                            } else if (width > 900) {
                              crossAxisCount = 4;
                            } else if (width > 600) {
                              crossAxisCount = 3;
                            }

                            return GridView.builder(
                              itemCount: controller.members.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h,
                                    childAspectRatio:
                                        0.7, // image takes more space vertically
                                  ),
                              itemBuilder: (_, index) {
                                final m = controller.members[index];
                                return GestureDetector(
                                  onTap: () => Get.to(
                                    () => MemberDetailScreen(member: m),
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    elevation: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12.r),
                                          ),
                                          child: Image.memory(
                                            base64Decode(m['imageBase64']),
                                            height: 120.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: Column(
                                            children: [
                                              CustomText(
                                                m['name'] ?? '',
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4.h),
                                              CustomText(
                                                '${StringUtils.age}: ${m['age']}',
                                                fontSize: 10.sp,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              );
      }),
    );
  }

  void pickImageWeb() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file); // for canvas drawing

      reader.onLoadEnd.listen((event) async {
        try {
          final compressedBytes = await compressImageForWeb(
            reader.result as String,
            maxSizeInBytes: 950000, // 950 KB
          );

          if (compressedBytes.length > 1000000) {
            Get.snackbar("Error", "Image is too large even after compression.");
            return;
          }

          controller.selectedImageBytes = compressedBytes;
          setState(() {}); // update preview
        } catch (e) {
          print("❌ Compression error: $e");
          Get.snackbar("Error", "Image compression failed.");
        }
      });
    });
  }

  Future<Uint8List> compressImageForWeb(
    String dataUrl, {
    int maxSizeInBytes = 950000,
    int initialWidth = 1024,
  }) async {
    final image = html.ImageElement();
    final completer = Completer<Uint8List>();
    image.src = dataUrl;

    image.onLoad.listen((_) {
      final canvas = html.CanvasElement();
      final ctx = canvas.context2D;

      final originalWidth = image.width!;
      final originalHeight = image.height!;
      final ratio = originalHeight / originalWidth;

      double quality = 0.9;
      int width = originalWidth > initialWidth ? initialWidth : originalWidth;
      int height = (width * ratio).toInt();

      Uint8List lastBytes = Uint8List(0);

      void compressLoop() {
        canvas.width = width;
        canvas.height = height;
        ctx.drawImageScaled(image, 0, 0, width, height);

        final compressedDataUrl = canvas.toDataUrl("image/jpeg", quality);
        final base64Str = compressedDataUrl.split(",").last;
        lastBytes = base64Decode(base64Str);

        if (lastBytes.length <= maxSizeInBytes || quality <= 0.2) {
          completer.complete(lastBytes);
        } else {
          // decrease quality/width and try again
          quality -= 0.1;
          if (quality < 0.3) width -= 100;
          height = (width * ratio).toInt();
          compressLoop();
        }
      }

      compressLoop();
    });

    image.onError.listen(
      (e) => completer.completeError("Image failed to load"),
    );

    return completer.future;
  }

  void showAddMemberDialog() {
    controller.nameCtrl.clear();
    controller.ageCtrl.clear();
    controller.educationCtrl.clear();
    controller.addressCtrl.clear();
    controller.mobileCtrl.clear();
    // controller.vadaCtrl.clear();
    controller.selectedGender = null;
    controller.selectedImageBytes = null;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: CustomText(
            StringUtils.addMember,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: controller.selectedImageBytes != null
                            ? MemoryImage(controller.selectedImageBytes!)
                            : AssetImage(AssetUtils.user) as ImageProvider,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            html.FileUploadInputElement uploadInput =
                                html.FileUploadInputElement();
                            uploadInput.accept = 'image/*';
                            uploadInput.click();

                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              final reader = html.FileReader();

                              reader.readAsArrayBuffer(file);
                              reader.onLoadEnd.listen((event) {
                                setState(() {
                                  controller.selectedImageBytes =
                                      reader.result as Uint8List;
                                });
                              });
                            });
                          },
                          child: CircleAvatar(
                            radius: 12.r,
                            child: Icon(
                              Icons.camera_alt,
                              size: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CommonTextField(
                    controller: controller.nameCtrl,
                    label: StringUtils.name,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 10.h),
                  CommonTextField(
                    controller: controller.ageCtrl,
                    label: StringUtils.age,
                    keyboardType: TextInputType.number,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 10.h),
                  CommonTextField(
                    controller: controller.educationCtrl,
                    label: StringUtils.education,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 10.h),
                  CommonTextField(
                    controller: controller.addressCtrl,
                    label: StringUtils.address,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 10.h),
                  CommonTextField(
                    controller: controller.mobileCtrl,
                    label: StringUtils.mobileNumber,
                    keyboardType: TextInputType.phone,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 10.h),
                  CommonDropdownField(
                    label: StringUtils.sex,
                    items: [StringUtils.male, StringUtils.female],
                    value: controller.selectedGender,
                    onChanged: (val) =>
                        setState(() => controller.selectedGender = val),
                    validator: _requiredValidator,
                  ),

                  // SizedBox(height: 10.h),
                  // CommonTextField(
                  //   controller: controller.vadaCtrl,
                  //   label: StringUtils.vadaName,
                  //   validator: _requiredValidator,
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomBtn(
                  text: StringUtils.cancel,
                  width: 100.w,
                  onPressed: () => Get.back(),
                  backgroundColor: Colors.grey.shade300,
                ),
                SizedBox(width: 10.w),
                CustomBtn(
                  width: 100.w,
                  text: StringUtils.add,
                  onPressed: () async {
                    try {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.selectedImageBytes == null) {
                          showCustomSnackBar(
                            context: context,
                            message: "Please select a profile image.",
                          );
                          return;
                        }

                        controller.isLoading.value = true;
                        Get.back();

                        await controller.addMember(
                          villageId: widget.villageId,
                          tadId: widget.tadId,
                          parivarId: widget.parivarId,
                          data: {
                            'name': controller.nameCtrl.text.trim(),
                            'age': controller.ageCtrl.text.trim(),
                            'education': controller.educationCtrl.text.trim(),
                            'address': controller.addressCtrl.text.trim(),
                            'mobile': controller.mobileCtrl.text.trim(),
                            'gender': controller.selectedGender,
                            // 'vadaName': controller.vadaCtrl.text.trim(),
                          },
                          imageBytes: controller.selectedImageBytes!,
                        );

                        await controller.loadMembers(
                          villageId: widget.villageId,
                          tadId: widget.tadId,
                          parivarId: widget.parivarId,
                        );
                      } else {
                        showCustomSnackBar(
                          context: context,
                          message: StringUtils.pleaseFillAllDetails,
                        );
                      }
                    } catch (e) {
                      logs("❌ Error during onPressed: $e");
                    } finally {
                      controller.isLoading.value = false;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) =>
      value == null || value.isEmpty ? StringUtils.required : null;
}
