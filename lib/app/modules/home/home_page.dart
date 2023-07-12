import 'package:blog_app_flutter/app/modules/home/home_controller.dart';
import 'package:blog_app_flutter/app/modules/posts/posts_page.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_page.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:blog_app_flutter/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('Blog App'),
            actions: [
              IconButton(
                  onPressed: () {
                    logout().then((value) =>
                        Get.offNamedUntil(AppRoutes.login, (route) => false));
                  },
                  icon: Icon(Icons.exit_to_app)),
            ],
          ),
          body: controller.currentIndex == 0 ? PostsPage() : ProfilePage(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.postForm,arguments: ['Add Post',null]);
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
              notchMargin: 5,
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
                ],
                currentIndex: controller.currentIndex.value,
                onTap: (val) {
                  controller.setCurrentIndex(val);
                },
              )),
        ));
  }
}
