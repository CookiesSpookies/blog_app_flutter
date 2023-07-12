import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/modules/register/register_controller.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
          key: controller.registerFormKey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              TextFormField(
                  controller: controller.nameController,
                  validator: controller.validateName,
                  decoration: kInputDecoration('Name')),
              const SizedBox(
                height: 10,
              ),
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
              TextFormField(
                controller: controller.passwordConfirmController,
                obscureText: true,
                validator: controller.validateConfirmedPassword,
                decoration: kInputDecoration('Confirm Password'),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : kTextButton('Login', () {
                      if (controller.registerFormKey.currentState!.validate()) {
                        controller.setLoadingStatus(true);
                        controller.registerUser();
                      }
                    })),
              const SizedBox(
                height: 10,
              ),
              kLoginRegisterHint('Already have an account? ', 'Login',
                  () => Get.offNamedUntil(AppRoutes.login, (route) => false))
            ],
          )),
    );
  }
}
