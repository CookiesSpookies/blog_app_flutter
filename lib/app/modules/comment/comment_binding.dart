
import 'package:blog_app_flutter/app/modules/comment/comment_controller.dart';
import 'package:get/get.dart';

class CommentsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CommentsController());
  }
}