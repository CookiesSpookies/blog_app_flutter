
import 'package:blog_app_flutter/app/modules/posts_form/post_form_controller.dart';
import 'package:get/get.dart';

class PostFormBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PostFormController());
  }
}