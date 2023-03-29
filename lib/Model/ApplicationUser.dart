import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:solution_challenge_v1/Model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Comment.dart';
import 'Contact.dart';

class ApplicationUser {
  late String _username;
  late String _email;
  late String _password;
  late bool _isDarkMode;
  final String? id;
  var likedPosts = [];
  var likedComments = [];
  List<Contact> emergencyContacts = [];
  late String _profilePicture;
  late bool _rememberMe;
  late bool _isEnglishLanguage;

  ApplicationUser({
    required String username,
    required String email,
    required var this.likedPosts,
    required var this.likedComments,
    String? id,
    required String profilePicture,
  })  : _username = username,
        _email = email,
        id = id,
        _profilePicture = profilePicture;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  bool get isDarkMode => _isDarkMode;

  String get getProfilePicture => _profilePicture;
  bool get getRememberMe => _rememberMe;
  bool get getIsEnglishLanguage => _isEnglishLanguage;

  void setUsername(String username) {
    _username = username;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setIsDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
  }

  void setProfilePicture(String profilePicture) {
    this._profilePicture = profilePicture;
  }

  void setRememberMe(bool rememberMe) {
    this._rememberMe = rememberMe;
  }

  void setIsEnglishLanguage(bool isEnglishLanguage) {
    this._isEnglishLanguage = isEnglishLanguage;
  }

  toJson() {
    return {
      "email": email,
      "name": username,
      "profile image": _profilePicture,
      "liked posts": likedPosts,
      "liked comments": likedComments,
    };
  }

  factory ApplicationUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ApplicationUser(
        email: data["email"],
        username: data["name"],
        id: document.id,
        likedPosts: data["liked posts"],
        likedComments: data["liked comments"],
        profilePicture: data["profile image"]);
  }
}
