import 'dart:async';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.pushReplacementNamed(context, '/homeScreen');
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CircularProgressIndicator(), // Add circular progress indicator
            const SizedBox(
                height: 16), // Add some space between the indicator and text
            const Text('Loading...'), // Add loading text
          ],
        ),
      ),
    );
  }
}
