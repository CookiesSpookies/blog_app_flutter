import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/modules/home/home_page.dart';
import 'package:blog_app_flutter/app/modules/login/login_page.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var token = ''.obs;

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  void checkAuth() async {
    token.value = await getToken();
    if (token.value == '') {
      Get.offNamedUntil(AppRoutes.login, (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Get.offNamedUntil(AppRoutes.home, (route) => false);
      } else if (response.error == unauthorized) {
        Get.offNamedUntil(AppRoutes.login, (route) => false);
      } else {
        Get.snackbar(
          'ERROR',
          '${response.error}',
          snackPosition: SnackPosition.TOP,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      }
    }
  }
}
