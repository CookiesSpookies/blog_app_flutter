import 'dart:io';
import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/models/user.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<User> user = User().obs;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  final ProfileFormKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void onInit() {
    retrieveUsers();  
    super.onInit();
  }

  //get all post
  void retrieveUsers() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      user.value = response.data as User;
      textController.text = user.value.name ?? '';
      loading.value = loading.value ? !loading.value : loading.value;
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
      loading.value = !loading.value;
    }
  }

  //get all post
  void updateProfile() async {
    ApiResponse response = await editUser(textController.text, getStringImage(imageFile));
    if (response.error == null) {
      loading.value = false;
      Get.snackbar(
        'INFO',
        '${response.data}',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
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
      loading.value = false;
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }
}
