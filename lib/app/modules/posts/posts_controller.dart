import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/models/post.dart';
import 'package:blog_app_flutter/app/models/user.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/post_service.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  var loading = false.obs;
  var postList = <dynamic>[].obs;
  var userId = 0;

  @override
  void onInit(){
    retrievePosts();
    super.onInit();
  }

  //get all post
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPosts();
    if(response.error == null){
      postList.value = response.data as List<dynamic>;
      loading.value = loading.value ? !loading.value : loading.value;
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

  void handlePostLikeDislike (int postId) async{
    ApiResponse response = await likeUnlikePost(postId);
    if(response.error == null){
      retrievePosts();
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
    }
  }

  void handleDeletePost (int postId) async{
    ApiResponse response = await deletePost(postId);
    if(response.error == null){
      retrievePosts();
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
    }
  }
}
