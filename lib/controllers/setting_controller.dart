import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final villages = <String>[].obs;
  final tads = <String>[].obs;
  final parivars = <String>[].obs;

  void addItem(String type, String value) {
    switch (type) {
      case "Village":
        villages.add(value);
        break;
      case "Tad":
        tads.add(value);
        break;
      case "Parivar":
        parivars.add(value);
        break;
    }
  }
}
