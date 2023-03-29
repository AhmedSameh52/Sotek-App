import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solution_challenge_v1/Model/Comment.dart';
import 'package:solution_challenge_v1/Model/article.dart';
import 'package:solution_challenge_v1/Model/post.dart';
import 'package:solution_challenge_v1/main.dart';

class Admin {
  final String username = 'Admin';
  final String password = 'Admin';
  final _db = FirebaseFirestore.instance;

  // add article to firebase
  Future<void> addArticle(String title, String imageUrl, String author,
      String postedOn, String link, int readTime) async {
    Article a1 = Article(
        title: title,
        imageUrl: imageUrl,
        author: author,
        postedOn: postedOn,
        link: link,
        readTime: readTime);
    a1.dateString = DateTime.parse(postedOn);
    articles.add(a1);
    articles.sort((b, a) => a.dateString.compareTo(b.dateString));
    await _db.collection("articles").add(a1.toJson());

    //articles.insert(0, a1); law msh 3ayzeen n3ml sorting
  }

  // get articles from firebase
  // Future<List<Article>> fetchArticles() async {
  //   final snapshot = await _db.collection("articles").get();
  //   final articleData =
  //       snapshot.docs.map((e) => Article.fromSnapshot(e)).toList();
  //   articles = articleData;
  //   return articleData;
  // }

  deleteArticle(Article article) {
    // articles.removeWhere((element) => element.link == article.link);
    FirebaseFirestore.instance.collection('articles').doc(article.id).delete();
  }
  // Future<void> deleteArticle(Article article) async {
  //   final articleRef =
  //       FirebaseFirestore.instance.collection('articles').doc(article.id);
  //   try {
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       await transaction.delete(articleRef);
  //     });
  //     print('Article deleted successfully');
  //   } catch (e) {
  //     print('Failed to delete article: $e');
  //   }
  // }

  void editArticle(Article article, String title, String imageUrl) {
    if (title != null) article.title = title;
    if (imageUrl != null) article.imageUrl = imageUrl;
    FirebaseFirestore.instance
        .collection("articles")
        .doc(article.id)
        .update(article.toJson());
  }

  void deletePost(Post post) {
    userC.allPosts.removeWhere((element) => element.postID == post.postID);
    FirebaseFirestore.instance.collection('posts').doc(post.postID).delete();
    var snapshots = FirebaseFirestore.instance
        .collection('posts')
        .doc(post.postID)
        .collection('comments')
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
  }

  void deleteComment(Post newPost, Comment newComment) {
    newPost.comments
        .removeWhere((element) => newComment.commentID == element.commentID);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(newPost.postID)
        .collection("comments")
        .doc(newComment.commentID)
        .delete();
  }

  static List<Article> articles = [];
  // static List<Article> articles = [
  //   Article(
  //     title: "Instagram quietly limits ‘daily time limit’ option",
  //     author: "MacRumors",
  //     imageUrl: "https://picsum.photos/id/1000/960/540",
  //     postedOn: DateTime.now(),
  //     link: 'zeby',
  //     readTime: 5555,
  //   ),
  //   Article(
  //     title: "Google Search dark theme goes fully black for some on the web",
  //     imageUrl: "https://picsum.photos/id/1010/960/540",
  //     author: "9to5Google",
  //     postedOn: DateTime.now(),
  //     link: 'aaa',
  //     readTime: 55,
  //   ),
  //   Article(
  //     title: "Check your iPhone now: warning signs someone is spying on you",
  //     author: "New York Times",
  //     imageUrl: "https://picsum.photos/id/1001/960/540",
  //     postedOn: DateTime.now(),
  //     link: 'rrrr',
  //     readTime: 6666,
  //   ),
  //   Article(
  //     title:
  //         "Amazon’s incredibly popular Lost Ark MMO is ‘at capacity’ in central Europe",
  //     author: "MacRumors",
  //     imageUrl: "https://picsum.photos/id/1002/960/540",
  //     postedOn: DateTime.now(),
  //     link: 'sssss',
  //     readTime: 57,
  //   ),
  //   Article(
  //     title:
  //         "Panasonic's 25-megapixel GH6 is the highest resolution Micro Four Thirds camera yet",
  //     author: "Polygon",
  //     imageUrl: "https://picsum.photos/id/1020/960/540",
  //     postedOn: DateTime.now(),
  //     link: 'ddddd',
  //     readTime: 5,
  //   ),
  //   Article(
  //     title: "Samsung Galaxy S22 Ultra charges strangely slowly",
  //     author: "TechRadar",
  //     imageUrl: "https://picsum.photos/id/1021/960/540",
  //     postedOn: DateTime.now(),
  //     link: 'qqqqq',
  //     readTime: 6,
  //   ),
  //   Article(
  //     title: "Snapchat unveils real-time location sharing",
  //     author: "Fox Business",
  //     imageUrl: "https://picsum.photos/id/1060/960/540",
  //     postedOn: DateTime.now(),
  //     readTime: 1,
  //     link: 'zeby',
  //   ),
  // ];
}
