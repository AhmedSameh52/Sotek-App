import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/Comment.dart';

class Post {
  late String title;
  late String body;
  late String author;
  late String profileImage;
  late String date;
  late int likesCount;
  final String? postID;
  List<Comment> comments = [];

  Post(
      {required this.likesCount,
      required this.title,
      required this.body,
      required this.profileImage,
      required this.author,
      required this.date,
      this.postID});

  toJson() {
    return {
      "author": author,
      "title": title,
      "body": body,
      "profile image": profileImage,
      "date": date,
      "likes count": likesCount,
    };
  }

  factory Post.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Post(
      title: data["title"],
      body: data["body"],
      profileImage: data["profile image"],
      author: data["author"],
      date: data["date"],
      postID: document.id,
      likesCount: data["likes count"],
    );
  }
}
