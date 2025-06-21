import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final educationCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  // final vadaCtrl = TextEditingController();

  String? selectedGender;
  Uint8List? selectedImageBytes;
  final isLoading = false.obs;
  final members = <Map<String, dynamic>>[].obs;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get userRef =>
      FirebaseFirestore.instance.collection('users');

  Future<void> addMember({
    required String villageId,
    required String tadId,
    required String parivarId,
    required Map<String, dynamic> data,
    required Uint8List imageBytes,
  }) async {
    print("👉 addMember() called");
    try {
      isLoading.value = true;

      print("🧪 Image byte length: ${imageBytes.length}");
      final base64Image = base64Encode(imageBytes);
      print("✅ Base64 encoded image length: ${base64Image.length}");

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("❌ User not logged in");
        throw Exception("User not logged in");
      }

      final memberData = {
        ...data,
        'imageBase64': base64Image,
        'createdAt': Timestamp.now(),
      };

      print("📤 Saving to Firestore...");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('villages')
          .doc(villageId)
          .collection('tads')
          .doc(tadId)
          .collection('parivars')
          .doc(parivarId)
          .collection('members')
          .add(memberData);

      print("✅ Member added with base64 image");
    } catch (e) {
      print("🔥 Error in addMember(): $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print("🔁 isLoading reset to false");
    }
  }

  Future<void> loadMembers({
    required String villageId,
    required String tadId,
    required String parivarId,
  }) async {
    try {
      isLoading.value = true;
      final ref = userRef
          .doc(uid)
          .collection('villages')
          .doc(villageId)
          .collection('tads')
          .doc(tadId)
          .collection('parivars')
          .doc(parivarId)
          .collection('members');
      print("----Finalyy isLoading.value 5 ${isLoading.value}");

      final snapshot = await ref.get();

      members.value = snapshot.docs.map((doc) {
        return {'docId': doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();
    } catch (e) {
      print('❌ Error loading members: $e');
    } finally {
      print("----Finalyy isLoading.value 6 ${isLoading.value}");

      isLoading.value = false;
    }
  }
}
