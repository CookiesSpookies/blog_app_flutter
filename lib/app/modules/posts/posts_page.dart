import 'dart:math';

import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/models/post.dart';
import 'package:blog_app_flutter/app/modules/posts/posts_controller.dart';
import 'package:blog_app_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsPage extends GetView<PostsController> {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () {
              return controller.retrievePosts();
            },
            child: ListView.builder(
              itemCount: controller.postList.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = controller.postList[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        image: post.user!.image != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    '${post.user!.image}'),fit: BoxFit.cover)
                                            : null,
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.amber),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${post.user!.name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            post.user!.id == controller.userId
                                ? PopupMenuButton(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                      ),
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text('Edit'),
                                        value: 'edit',
                                      ),
                                      PopupMenuItem(
                                        child: Text('Delete'),
                                        value: 'delete',
                                      ),
                                    ],
                                    onSelected: (val) {
                                      if (val == 'edit') {
                                        Get.toNamed(AppRoutes.postForm, arguments: ['Edit Post',post]);
                                      } else {
                                        controller.handleDeletePost(post.id!);
                                      }
                                    },
                                  )
                                : SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('${post.body}'),
                        post.image != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage('${post.image}'),
                                        fit: BoxFit.cover)),
                              )
                            : SizedBox(
                                height: post.image != null ? 0 : 10,
                              ),
                        Row(
                          children: [
                            kLikeAndComment(
                                post.likesCount ?? 0,
                                post.selfLiked ?? false
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                post.selfLiked ?? false
                                    ? Colors.red
                                    : Colors.black38,
                                () => controller.handlePostLikeDislike(post.id!)),
                            Container(
                              height: 25,
                              width: 0.5,
                              color: Colors.black,
                            ),
                            kLikeAndComment(post.commentsCount ?? 0,
                                Icons.sms_outlined, Colors.black54, () {
                                  Get.toNamed(AppRoutes.comment,arguments: post.id);
                                }),
                          ],
                        )
                      ]),
                );
              },
            ),
          ));
  }
}
