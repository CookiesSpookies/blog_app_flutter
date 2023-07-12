import 'package:blog_app_flutter/app/modules/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}