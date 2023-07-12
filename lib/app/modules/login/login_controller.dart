import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/models/user.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var loading = false.obs;
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setLoadingStatus(val) => loading.value = val;

  void loginUser() async {
    ApiResponse response = await login(emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      Get.snackbar(
        'ERROR',
        '${response.error}',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
    setLoadingStatus(false);
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Get.offNamedUntil('home', (route) => false);
  }

  String? validateEmail (String? val) {
    return val!.isEmpty ? 'Invalid Email Address' : null;
  }

  String? validatePassword (String? val) {

    return val!.length < 6 ? 'Required at least 6 chars' : null;
  }
}
