import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/utils/Theme/app_text_style.dart';
import '../commonWidgits/custom_btn.dart';
import '../commonWidgits/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingController extends GetxController {
  final isLoading = false.obs;
  final villages = <Map<String, dynamic>>[].obs;
  final tads = <Map<String, dynamic>>[].obs;
  final parivars = <Map<String, dynamic>>[].obs;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get villageRef => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('villages');

  @override
  void onInit() {
    fetchVillages();
    super.onInit();
  }

  Future<void> fetchVillages() async {
    try {
      isLoading.value = true;
      final snapshot = await villageRef.orderBy('id').get();
      // villages.value = snapshot.docs
      //     .map((doc) => doc.data() as Map<String, dynamic>)
      //     .toList();
      villages.value = snapshot.docs
          .map((doc) => {'docId': doc.id, 'id': doc['id'], 'name': doc['name']})
          .toList();
    } catch (e) {
      print("⚠️ Error in fetchVillages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addVillage(String name) async {
    try {
      isLoading.value = true;
      final snapshot = await villageRef.orderBy('id').get();
      final existingIds = snapshot.docs
          .map((doc) => doc['id'].toString())
          .toList();
      int nextIdNum = 1;
      while (existingIds.contains('V${nextIdNum.toString().padLeft(2, '0')}')) {
        nextIdNum++;
      }
      final id = 'V${nextIdNum.toString().padLeft(2, '0')}';
      await villageRef.add({'id': id, 'name': name});
      await fetchVillages();
    } catch (e) {
      print("⚠️ Error in addVillage: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTads(String villageId) async {
    try {
      isLoading.value = true;
      final ref = villageRef.doc(villageId).collection('tads');
      final snapshot = await ref.orderBy('id').get();
      tads.value = snapshot.docs
          .map((doc) => {'docId': doc.id, 'id': doc['id'], 'name': doc['name']})
          .toList();
    } catch (e) {
      print("⚠️ Error in loadTads: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTad(String villageDocId, String name) async {
    try {
      isLoading.value = true;
      final ref = villageRef.doc(villageDocId).collection('tads');
      // final ref = villageRef.doc(villageId).collection('tads');
      final snapshot = await ref.orderBy('id').get();
      final existingIds = snapshot.docs
          .map((doc) => doc['id'].toString())
          .toList();
      int nextIdNum = 1;
      while (existingIds.contains('T${nextIdNum.toString().padLeft(2, '0')}')) {
        nextIdNum++;
      }
      final id = 'T${nextIdNum.toString().padLeft(2, '0')}';
      await ref.add({'id': id, 'name': name});
      await loadTads(villageDocId);
    } catch (e) {
      print("⚠️ Error in addTad: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadParivars(String villageId, String tadId) async {
    try {
      isLoading.value = true;
      final ref = villageRef
          .doc(villageId)
          .collection('tads')
          .doc(tadId)
          .collection('parivars');
      final snapshot = await ref.orderBy('id').get();

      parivars.value = snapshot.docs.map((doc) {
        return {
          'docId': doc.id, // ✅ Needed to pass correct ID
          'id': doc['id'], // Still fine to keep
          'name': doc['name'],
        };
      }).toList();
    } catch (e) {
      print("⚠️ Error in loadParivars: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addParivar(String villageId, String tadId, String name) async {
    try {
      isLoading.value = true;
      final ref = villageRef
          .doc(villageId)
          .collection('tads')
          .doc(tadId)
          .collection('parivars');
      final snapshot = await ref.orderBy('id').get();
      final existingIds = snapshot.docs
          .map((doc) => doc['id'].toString())
          .toList();
      int nextIdNum = 1;
      while (existingIds.contains('P${nextIdNum.toString().padLeft(2, '0')}')) {
        nextIdNum++;
      }
      final id = 'P${nextIdNum.toString().padLeft(2, '0')}';
      await ref.add({'id': id, 'name': name});
      await loadParivars(villageId, tadId);
    } catch (e) {
      print("⚠️ Error in addParivar: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showAddDialog({
    required BuildContext context,
    required String title,
    required Function(String name) onSubmit,
  }) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: CustomText(
          'Add $title',
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
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
                backgroundColor: Colors.grey.shade400,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
                borderRadius: 8.r,
              ),
              SizedBox(width: 12.w),
              CustomBtn(
                onPressed: () async {
                  final value = textController.text.trim();
                  if (value.isNotEmpty) {
                    Get.back();
                    await onSubmit(value);
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
}
