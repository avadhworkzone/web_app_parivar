import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_app_demo/controllers/main_controller.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import 'package:web_app_demo/utils/string_utils.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Icons.home_outlined,
                  label: StringUtils.home,
                  isSelected: controller.currentIndex.value == 0,
                  onTap: () => controller.currentIndex.value = 0,
                ),
                _NavBarItem(
                  icon: Icons.settings_outlined,
                  label: StringUtils.settings,
                  isSelected: controller.currentIndex.value == 1,
                  onTap: () => controller.currentIndex.value = 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Theme.of(context).primaryColor : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18.sp),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              CustomText(
                label,
                color: color,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
