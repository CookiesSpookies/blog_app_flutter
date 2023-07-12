import 'package:blog_app_flutter/app/modules/loading/loading_binding.dart';
import 'package:blog_app_flutter/app/modules/loading/loading_page.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_controller.dart';
import 'package:blog_app_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/posts/posts_controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: LoadingBinding(),
      home: const SafeArea(child: LoadingPage()),
      getPages: AppPages.pages,
    );
  }
}