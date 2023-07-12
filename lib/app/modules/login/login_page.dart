import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/modules/login/login_controller.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
          key: controller.loginFormKey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                  decoration: kInputDecoration('Email')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                validator: controller.validatePassword,
                decoration: kInputDecoration('Password'),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : kTextButton('Login', () {
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.setLoadingStatus(true);
                        controller.loginUser();
                      }
                    })),
              const SizedBox(
                height: 10,
              ),
              kLoginRegisterHint('Dont have an account? ', 'Register',
                  () => Get.offNamedUntil(AppRoutes.register, (route) => false))
            ],
          )),
    );
  }
}
