// auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app_demo/screens/home_screen.dart';
import 'package:web_app_demo/screens/main_screen.dart';
import '../utils/string_utils.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  void showSnack(String message, {bool success = true}) {
    Get.snackbar(
      success ? "Success" : "Error",
      message,
      backgroundColor: success ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final user = userCredential.user;
      if (user != null) {
        showSnack("${StringUtils.loginSuccess} ${user.email}");
        Get.off(() => MainScreen());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = StringUtils.userNotRegistered;
          break;
        case 'wrong-password':
          errorMessage = StringUtils.wrongPassword;
          break;
        case 'invalid-email':
          errorMessage = StringUtils.invalidEmail;
          break;
        case 'invalid-credential':
          errorMessage = StringUtils.invalidCredential;
          break;
        case 'user-disabled':
          errorMessage = StringUtils.userDisabled;
          break;
        default:
          errorMessage = e.message ?? StringUtils.loginFailed;
      }
      showSnack(errorMessage, success: false);
    } catch (_) {
      showSnack(StringUtils.unexpectedError, success: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final user = userCredential.user;
      if (user != null) {
        showSnack("${StringUtils.registerSuccess} ${user.email}");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = StringUtils.emailAlreadyUsed;
          break;
        case 'invalid-email':
          errorMessage = StringUtils.invalidEmail;
          break;
        case 'weak-password':
          errorMessage = StringUtils.weakPassword;
          break;
        default:
          errorMessage = e.message ?? StringUtils.registrationFailed;
      }
      showSnack(errorMessage, success: false);
    } catch (_) {
      showSnack(StringUtils.unexpectedError, success: false);
    } finally {
      isLoading.value = false;
    }
  }
}
