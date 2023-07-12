import 'dart:io';

import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: ListView(children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: controller.imageFile == null
                              ? controller.user.value.image != null
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          '${controller.user.value.image}'),
                                      fit: BoxFit.cover)
                                  : null
                              : DecorationImage(
                                  image: FileImage(
                                      controller.imageFile ?? File('')),
                                  fit: BoxFit.cover),
                          color: Colors.amber),
                    ),
                    onTap: () {
                      controller.getImage();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: controller.ProfileFormKey,
                  child: TextFormField(
                    decoration: kInputDecoration('Name'),
                    controller: controller.textController,
                    validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                kTextButton('Update', (){
                  if(controller.ProfileFormKey.currentState!.validate()){
                    controller.loading.value = true;
                    controller.updateProfile();
                  }
                })
              ]),
            ),
    );
  }
}
