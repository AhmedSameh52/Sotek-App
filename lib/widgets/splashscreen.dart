import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge_v1/main.dart';
import 'login_screen.dart';
import 'themeManager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(max: 1);
    Timer(const Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      email == null ? FirebaseAuth.instance.signOut() : null;
      email == null
          ? Navigator.of(context).pushReplacementNamed('/loginScreen')
          : Navigator.of(context).pushReplacementNamed('/loadingScreen');
      if (email != null) {
        await userC.getUserDetails(email);
        await userC.getAllContacts();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/login_screen_images/sotek.png",
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            // ignore: prefer_const_constructors
            Text(
              "Sotek - صوتك",
              style: TextStyle(
                fontFamily: 'Figtree',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: !isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
