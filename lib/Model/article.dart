import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String? id;
  String title;
  String imageUrl;
  final String author;
  final String postedOn;
  final String link;
  final int readTime;
  late DateTime dateString = DateTime.now();

  Article(
      {this.id,
      required this.title,
      required this.imageUrl,
      required this.author,
      required this.postedOn,
      required this.link,
      required this.readTime});

  toJson() {
    return {
      "author": author,
      "image url": imageUrl,
      "posted on": postedOn,
      "link": link,
      "read time": readTime,
      "title": title
    };
  }

  factory Article.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Article(
        id: document.id,
        title: data["title"],
        imageUrl: data["image url"],
        author: data["author"],
        postedOn: data["posted on"],
        link: data["link"],
        readTime: data["read time"]);
  }
}
