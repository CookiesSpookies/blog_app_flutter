import 'package:blog_app_flutter/app/modules/comment/comment_binding.dart';
import 'package:blog_app_flutter/app/modules/comment/comment_page.dart';
import 'package:blog_app_flutter/app/modules/home/home_binding.dart';
import 'package:blog_app_flutter/app/modules/home/home_page.dart';
import 'package:blog_app_flutter/app/modules/loading/loading_binding.dart';
import 'package:blog_app_flutter/app/modules/loading/loading_page.dart';
import 'package:blog_app_flutter/app/modules/login/login_binding.dart';
import 'package:blog_app_flutter/app/modules/login/login_page.dart';
import 'package:blog_app_flutter/app/modules/posts/posts_binding.dart';
import 'package:blog_app_flutter/app/modules/posts/posts_page.dart';
import 'package:blog_app_flutter/app/modules/posts_form/post_form_binding.dart';
import 'package:blog_app_flutter/app/modules/posts_form/post_form_page.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_binding.dart';
import 'package:blog_app_flutter/app/modules/profile/profile_page.dart';
import 'package:blog_app_flutter/app/modules/register/register_binding.dart';
import 'package:blog_app_flutter/app/modules/register/register_page.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingPage(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.post,
      page: () => const PostsPage(),
      binding: PostsBinding(),
    ),
    GetPage(
      name: AppRoutes.postForm,
      page: () => const PostFormPage(),
      binding: PostFormBinding(),
    ),
     GetPage(
      name: AppRoutes.comment,
      page: () => const CommentsPage(),
      binding: CommentsBinding(),
    ),
  ];
}


