import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/widgets/signup_screen.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _emailController = TextEditingController();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('success'),
            );
          });
    } on FirebaseAuthException catch (e) {
      Navigator.pushReplacementNamed(context, '/resetPasswordScreen');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/login_screen_images/background.png',
          ),
          fit: BoxFit.cover,
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // SizedBox(
          //   height: height * 0.3,
          // ),
          Container(
            margin: EdgeInsets.only(left: width * 0.07, right: width * 0.07),
            child: Text(
              'Please enter your email to recieve link for password reset',
              style: TextStyle(
                  color: Color.fromRGBO(76, 83, 101, 1), fontSize: 20),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.07, right: width * 0.07),
            child: TextFormField(
              // TextField for the Email address
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(248, 225, 210, 1),
                filled: true,
                labelText: 'Email',
                hintText: 'Please Enter your Email',
                prefixIcon: const Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            // Sign in button, Used sizedbox to adjust the button's size
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                resetPassword();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(246, 145, 138, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  )),
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
