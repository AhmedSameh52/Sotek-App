import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/Comment.dart';
import 'package:solution_challenge_v1/Model/post.dart';
import 'package:solution_challenge_v1/Model/Contact.dart';
import 'package:solution_challenge_v1/Model/ApplicationUser.dart';
import 'package:solution_challenge_v1/main.dart';
import 'package:solution_challenge_v1/widgets/newPost.dart';

class userController {
  late ApplicationUser currentUser;
  late int _verificationNumber;
  final _db = FirebaseFirestore.instance;
  late List<Post> allPosts;
  late List<Contact> allContacts;

  userController(String email, String password) {
    // validate(email, password);   // If user is null then no user in the database and should not log in
    currentUser = ApplicationUser(
      username: 'username',
      email: email,
      likedPosts: [],
      likedComments: [],
      profilePicture: 'assets/images/communityImages/amr.jpg',
    );
  }

  // User validate(String email, String password) {
  //   // Should validate the username and password across all the instances of user
  //   return null;
  // }

  void changeLanguage(bool isEnglish) {
    currentUser.setIsEnglishLanguage(isEnglish);
  }

  void changeDarkMode(bool isDarkMode) {
    currentUser.setIsDarkMode(isDarkMode);
  }

  void changeEmail(String email, int verificationNumber) {
    sendVerificationNumber();
    bool isValid = validateEmail(email, verificationNumber);
    if (isValid) {
      currentUser.setEmail(email);
    } else {
      // DISPLAY ERROR MESSAGE
    }
  }

  void sendVerificationNumber() {
    _verificationNumber = Random().nextInt(100000);
  }

  bool validateEmail(String email, int verificationNumber) {
    // for(int i = 0; i <= USERSNUMBERS; I++){                //CHECK FOR EMAIL IN ALL USERS (FIREBASE)
    //   CHECK FOR THE SAME EMAIL IN ALL USERS
    // }
    if (verificationNumber == _verificationNumber) {
      return true;
    }
    return false;
  }

  void changeUsername(String username) async {
    bool isValid = validateUsername(username);
    if (isValid) {
      currentApplicationUser!.setUsername(username);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentApplicationUser!.id)
          .update(currentApplicationUser!.toJson());
    } else {
      // DISPLAY ERROR MESSAGE
    }
  }

  bool validateUsername(String username) {
    //CHECK FOR USERNAME IN ALL USERS (FIREBASE)
    return true;
  }

  void changePassword(String email) async {
    //MAKE A CONFIRM PASSWORD FUNCTION
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void changePofilePicture(String profilePicture) async {
    currentApplicationUser!.setProfilePicture(profilePicture);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
  }

  void changeRememberMe(bool rememberMe) {
    currentUser.setRememberMe(rememberMe);
  }

  Future<void> addEmergencyContact(Contact newContact) async {
    final _db = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .collection("emergency contacts")
        .add(newContact.toJson());
    tempPosts = allPosts;
    currentUser.emergencyContacts.add(newContact);
    await getAllContacts();
  }

  Future<void> deleteEmergencyContact(Contact newContact) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentApplicationUser!.id)
        .collection("emergency contacts")
        .doc(newContact.contactID)
        .delete();
    var snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(currentApplicationUser!.id)
        .collection('emergency contacts')
        .doc(newContact.contactID)
        .delete();

    currentUser.emergencyContacts.removeWhere(
        (element) => element.phoneNumber == newContact.phoneNumber);
    await getAllContacts();
  }

  Future<void> addPost(Post newPost) async {
    final _db = await FirebaseFirestore.instance
        .collection("posts")
        .add(newPost.toJson());
    await getAllPosts();
    tempPosts = allPosts;
  }

  Future<void> likePost(Post newPost) async {
    currentApplicationUser!.likedPosts.add(newPost.postID.toString());

    // await getAllPosts();
    // await getUserDetails(currentApplicationUser!.email);
    newPost.likesCount++;
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(newPost.postID)
        .update(newPost.toJson());
    await getPosts();
  }

  Future<void> unLikePost(Post newPost) async {
    currentApplicationUser!.likedPosts
        .removeWhere((element) => element == newPost.postID);

    // await getUserDetails(currentApplicationUser!.email);
    newPost.likesCount--;
    // await getAllPosts();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(newPost.postID)
        .update(newPost.toJson());
    await getPosts();
  }

  Future<void> createComment(Post newPost, Comment newComment) async {
    //newPost.comments.add(newComment);
    //currentUser.likedPosts.add(newPost);
    final _db = await FirebaseFirestore.instance
        .collection("posts")
        .doc(newPost.postID)
        .collection("comments")
        .add(newComment.toJson());
    await getAllComments(newPost);
  }

  void likeComment(Comment newComment, Post newPost) {
    currentApplicationUser!.likedComments.add(newComment.commentID.toString());

    // await getUserDetails(currentApplicationUser!.email);
    newComment.numLikes++;
    // await getAllPosts();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(newPost.postID)
        .collection("comments")
        .doc(newComment.commentID)
        .update(newComment.toJson());
    currentUser.likedComments.add(newComment);
  }

  void unLikeComment(Comment newComment, Post newPost) {
    // for (int i = 0; i < currentUser.likedPosts.length; i++) {
    //   currentUser.likedComments
    //       .removeWhere((element) => element.commentID == newComment.commentID);
    // }
    currentApplicationUser!.likedComments
        .removeWhere((element) => element == newComment.commentID);

    // await getUserDetails(currentApplicationUser!.email);
    newComment.numLikes--;
    // await getAllPosts();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(newPost.postID)
        .collection("comments")
        .doc(newComment.commentID)
        .update(newComment.toJson());
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentApplicationUser!.id)
        .update(currentApplicationUser!.toJson());
    currentUser.likedComments.add(newComment);
  }

  int postIDGenerator() {
    // We want to make sure each post has unique id
    return Random().nextInt(100000);
  }

  Future<List<Post>> getAllPosts() async {
    final snapshot = await _db.collection("posts").get();
    final postsData = snapshot.docs.map((e) => Post.fromSnapshot(e)).toList();
    allPosts = postsData;
    return postsData;
  }

  Future<List<Contact>> getAllContacts() async {
    final snapshot = await _db
        .collection("users")
        .doc(currentApplicationUser!.id)
        .collection("emergency contacts")
        .get();
    final contactsData =
        snapshot.docs.map((e) => Contact.fromSnapshot(e)).toList();
    currentApplicationUser!.emergencyContacts = contactsData;
    return contactsData;
  }

  Future<List<Comment>> getAllComments(Post newPost) async {
    final snapshot = await _db
        .collection("posts")
        .doc(newPost.postID)
        .collection("comments")
        .get();
    final commentsData =
        snapshot.docs.map((e) => Comment.fromSnapshot(e)).toList();
    newPost.comments = commentsData;
    return commentsData;
  }

  Future<ApplicationUser> getUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => ApplicationUser.fromSnapshot(e)).single;

    // // final snapshotPostsLiked = await FirebaseFirestore.instance
    // //     .collection("users")
    // //     .doc(userData.id)
    // //     .collection("postsLiked")
    // //     .get();

    // final snapshotPostsComments = await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(userData.id)
    //     .collection("commentsLiked")
    //     .get();

    // final snapshotContacts = await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(userData.id)
    //     .collection("contacts")
    //     .get();

    // final postsData = snapshotPostsLiked.docs.forEach((element) {
    //   currentApplicationUser!.likedPosts = element["postsLiked"];
    // });

    // final commentsData =
    //     snapshotPostsLiked.docs.map((e) => Comment.fromSnapshot(e)).toList();

    currentApplicationUser = userData;
    // //currentApplicationUser!.likedPosts = postsData;
    // currentApplicationUser!.likedComments = commentsData;
    return userData;
  }
}

// void main(List<String> args) {
//   Admin admin = new Admin('email', 'password');
//   admin.addPost('title', 'body', 'author', 'date');
//   admin.addPost('title1', 'body1', 'author1', 'date1');
//   //print(admin.currentUser.posts[0].title);
//   admin.deletePost('title', 'body', 'author', 'date');
//   print(admin.currentUser.posts[0].title);
//   // admin.deleteEmergencyContact('a', '11');
//   // admin.deleteEmergencyContact('b', '22');
//   // print(admin.currentUser.emergencyContacts);
// }
