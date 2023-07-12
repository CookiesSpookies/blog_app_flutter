import 'package:blog_app_flutter/app/constants/service_constants.dart';
import 'package:blog_app_flutter/app/models/api_responses.dart';
import 'package:blog_app_flutter/app/models/post.dart';
import 'package:blog_app_flutter/app/models/user.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/comment_service.dart';
import 'package:blog_app_flutter/app/services/post_service.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  dynamic postId = Get.arguments;
  final textController = TextEditingController();
  var commentList = <dynamic>[].obs;
  var loading = false.obs;
  var userId = 0;
  var editCommentId = 0.obs;

  @override
  void onInit() {
    retrieveComments();
    super.onInit();
  }

  //get all post
  Future<void> retrieveComments() async {
    userId = await getUserId();
    ApiResponse response = await getComments(postId);
    if (response.error == null) {
      commentList.value = response.data as List<dynamic>;
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

  void handleCreateComment() async {
    ApiResponse response =
        await createComment(postId ?? 0, textController.text);

    if (response.error == null) {
      textController.clear();
      retrieveComments();
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

  void handleDeleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);
    if (response.error == null) {
      retrieveComments();
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

  void handleEditComment() async {
    ApiResponse response = await editComment(editCommentId.value, textController.text);
    if (response.error == null) {
      editCommentId.value = 0;
      textController.clear();
      retrieveComments();
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
