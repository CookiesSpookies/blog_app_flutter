import 'package:blog_app_flutter/app/constants/function_constants.dart';
import 'package:blog_app_flutter/app/models/comment.dart';
import 'package:blog_app_flutter/app/modules/comment/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Obx(
              () => Column(children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.retrieveComments(),
                    child: ListView.builder(
                        itemCount: controller.commentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Comment com = controller.commentList[index];
                          return Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 0.5))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: com.user!.image != null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          '${com.user!.image}'),
                                                      fit: BoxFit.cover)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.blueGrey),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${com.user!.name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    com.user!.id == controller.userId
                                        ? PopupMenuButton(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
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
                                                controller.editCommentId.value =
                                                    com.id ?? 0;
                                                controller.textController.text =
                                                    com.comment ?? '';
                                              } else {
                                                controller.handleDeleteComment(
                                                    com.id ?? 0);
                                              }
                                            },
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('${com.comment}')
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black26, width: 0.5))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          decoration: kInputDecoration('Comment'),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (controller.textController.text.isNotEmpty) {
                              controller.loading.value = true;
                              if (controller.editCommentId.value > 0) {
                                controller.handleEditComment();
                              } else {
                                controller.handleCreateComment();
                              }
                            }
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                )
              ]),
            ),
    );
  }
}
