import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String author;
  late int numLikes;
  late String date;
  late String body;
  late String profileImage;
  final String? commentID;

  Comment({
    required this.author,
    required this.date,
    required this.body,
    required this.profileImage,
    required this.numLikes,
    this.commentID,
  });
  toJson() {
    return {
      "author": author,
      "number of likes": numLikes,
      "body": body,
      "date": date,
      "profile image": profileImage
    };
  }

  factory Comment.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Comment(
        body: data["body"],
        author: data["author"],
        date: data["date"],
        commentID: document.id,
        numLikes: data["number of likes"],
        profileImage: data["profile image"]);
  }
}
