import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:solution_challenge_v1/Model/post.dart';
import 'package:solution_challenge_v1/widgets/Community.dart';
import 'package:solution_challenge_v1/main.dart';

import '../firebase/admin.dart';

class newPost extends StatefulWidget {
  const newPost({Key? key}) : super(key: key);

  @override
  State<newPost> createState() => _newPostState();
}

class _newPostState extends State<newPost> {
  final bodyTextFieldController = TextEditingController();
  final titleTextFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    bodyTextFieldController.dispose();
    titleTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: titleTextFieldController,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: bodyTextFieldController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "What's New?",
                    hintStyle: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 99999,
                  autofocus: true,
                )
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (titleTextFieldController.text.isEmpty ||
                bodyTextFieldController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter both title and body.'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }

            await userC.addPost(
              Post(
                title: titleTextFieldController.text,
                body: bodyTextFieldController.text,
                profileImage: currentApplicationUser!.getProfilePicture,
                author: currentApplicationUser!.username,
                likesCount: 0,
                date: DateTime.now().toString(),
              ),
            );
            tempPosts = userC.allPosts;

            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/communityScreen');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode
                ? const Color.fromRGBO(255, 189, 183, 1)
                : const Color.fromRGBO(246, 145, 138, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            'Publish',
            style: TextStyle(fontFamily: 'Figtree', color: Colors.black),
          ),
        ),
      ),
    );
  }
}
