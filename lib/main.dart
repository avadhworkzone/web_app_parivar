import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/controllers/auth_controller.dart';
import 'package:web_app_demo/firebase_options.dart';
import 'package:web_app_demo/screens/home_screen.dart';
import 'package:web_app_demo/screens/login_page.dart';
import 'package:web_app_demo/screens/main_screen.dart';
import 'package:web_app_demo/utils/string_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyC5xGrykr0gj2CtlRMOWtnl_I15BMvokX8",
  //     authDomain: "webapp-a487f.firebaseapp.com",
  //     projectId: "webapp-a487f",
  //     storageBucket: "webapp-a487f.firebasestorage.app",
  //     messagingSenderId: "666802123103",
  //     appId: "1:666802123103:web:d4303a2da4482b1955c6ea",
  //     measurementId: "G-KTVCNMY11Z",
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringUtils.appName,
          home: FirebaseAuth.instance.currentUser == null
              ? LoginPage()
              : MainScreen(),
        );
      },
    );
  }
}
