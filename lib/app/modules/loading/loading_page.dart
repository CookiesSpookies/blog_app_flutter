import 'package:blog_app_flutter/app/modules/loading/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingController>(
      builder: (controller) => Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}