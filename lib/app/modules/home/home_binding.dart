
import 'package:blog_app_flutter/app/modules/home/home_controller.dart';
import 'package:blog_app_flutter/app/modules/posts/posts_controller.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PostsController());
    Get.lazyPut(() => ProfileController());
  }
}