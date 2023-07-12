import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/models/user.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  var loading = false.obs;
  
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }

  void setLoadingStatus(val) => loading.value = val;

  void registerUser() async {
    ApiResponse response = await register(nameController.text,emailController.text, passwordController.text);
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
    await pref.setInt('id', user.id ?? 0);
    Get.offNamedUntil(AppRoutes.home, (route) => false);
  }

  String? validateName (String? val) {

    return val!.isEmpty ? 'Invalid Name' : null;
  }

  String? validateEmail (String? val) {
    return val!.isEmpty ? 'Invalid Email Address' : null;
  }

  String? validatePassword (String? val) {

    return val!.length < 6 ? 'Required at least 6 chars' : null;
  }

  String? validateConfirmedPassword (String? val) {

    return val != passwordController.text ? 'Confirm password not match' : null;
  }
}