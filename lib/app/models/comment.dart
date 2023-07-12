import 'package:blog_app_flutter/app/models/user.dart';

class Comment {
  int? id;
  String? comment;
  User? user;

  Comment({
    this.id,
    this.comment,
    this.user
  });

  //function to convert json data to user model
  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      id: json['id'],
      comment: json['comment'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
      ) ,
    );
  }
}