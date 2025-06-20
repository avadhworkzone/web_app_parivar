import 'package:get/get.dart';
import 'package:web_app_demo/screens/home_screen.dart';
import 'package:web_app_demo/screens/setting_screen.dart';

class MainScreenController extends GetxController {
  RxInt currentIndex = 0.obs;

  final pages = [const HomeScreen(), SettingScreen()];
}
