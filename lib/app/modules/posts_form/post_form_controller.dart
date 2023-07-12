import 'dart:io';
import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/post_service.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostFormController extends GetxController {
  dynamic args = Get.arguments;
  final PostFormKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  var loading = false.obs;

@override
  void onInit() {
    if(args[1] != null){
      textController.text = args[1].body ?? '';
    }
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
  
  void createPosts() async {
    String? image = imageFile == null ? null : getStringImage(imageFile);
    ApiResponse response = await createPost(textController.text,image);
    if (response.error == null) {
      Get.back();
    } 
    else if(response.error == unauthorized){
       Get.offNamedUntil(AppRoutes.login, (route) => false);
    }
    else {
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

  void editPosts(int postId) async {
    ApiResponse response = await editPost(postId,textController.text);
    if (response.error == null) {
      Get.back();
    } 
    else if(response.error == unauthorized){
       Get.offNamedUntil(AppRoutes.login, (route) => false);
    }
    else {
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

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
  }
}
