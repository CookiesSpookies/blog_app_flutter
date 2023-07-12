import 'dart:io';

import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/modules/posts_form/post_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostFormPage extends GetView<PostFormController> {
  const PostFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.args[0]}'),
      ),
      body: Obx(
        () => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  controller.args[1] != null
                      ? SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              image: controller.imageFile == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(
                                          controller.imageFile ?? File('')),
                                      fit: BoxFit.cover)),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.black38,
                              ),
                              onPressed: () {
                                controller.getImage();
                              },
                            ),
                          ),
                        ),
                  Form(
                      key: controller.PostFormKey,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(
                          controller: controller.textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 9,
                          validator: (val) =>
                              val!.isEmpty ? 'Post body is required' : null,
                          decoration: InputDecoration(
                              hintText: "Post body...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38))),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: kTextButton('Post', () {
                        if (controller.PostFormKey.currentState!.validate()) {
                          controller.loading.value = !controller.loading.value;
                          if (controller.args[1] == null) {
                            controller.createPosts();
                          } else {
                            controller.editPosts(controller.args[1].id ?? 0);
                          }
                        }
                      })),
                ],
              ),
      ),
    );
  }
}
