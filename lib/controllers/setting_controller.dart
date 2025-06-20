import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final villages = <String>[].obs;
  final tads = <String>[].obs;
  final parivars = <String>[].obs;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final userRef = FirebaseFirestore.instance.collection('users');

  void fetchData() async {
    final doc = await userRef.doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      villages.value = List<String>.from(data['villages'] ?? []);
      tads.value = List<String>.from(data['tads'] ?? []);
      parivars.value = List<String>.from(data['parivars'] ?? []);
    }
  }

  void addItem(String type, String value) async {
    final fieldMap = {'Village': villages, 'Tad': tads, 'Parivar': parivars};

    final list = fieldMap[type];
    if (list != null && !list.contains(value)) {
      list.add(value);
      print("----list---$list");
      // ⛳ FIX: Use `.toList()` to convert RxList to List before saving
      await userRef.doc(uid).set({
        '${type.toLowerCase()}s': list.toList(),
      }, SetOptions(merge: true));
    }
  }
}
