import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/article.dart';
import 'package:solution_challenge_v1/Model/post.dart';
import 'package:solution_challenge_v1/widgets/CameraPage.dart';
import 'package:solution_challenge_v1/widgets/Community.dart';
import 'package:solution_challenge_v1/widgets/articleScreen.dart';
import 'package:solution_challenge_v1/widgets/contactAuthorities_screen.dart';
import 'package:solution_challenge_v1/widgets/contacts.dart';
import 'package:solution_challenge_v1/widgets/home.dart';
import 'package:solution_challenge_v1/widgets/loadingScreen.dart';
import 'package:solution_challenge_v1/widgets/login_screen.dart';
import 'package:solution_challenge_v1/widgets/newPost.dart';
import 'package:solution_challenge_v1/widgets/profile_screen.dart';
import 'package:solution_challenge_v1/widgets/resetPassword.dart';
import 'package:solution_challenge_v1/widgets/settings_screen.dart';
import 'package:solution_challenge_v1/widgets/signup_screen.dart';
import 'package:solution_challenge_v1/widgets/splashScreen.dart';

import 'commentCommunity.dart';

class RouteGenrator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => loginScreen());
      case '/signUpScreen':
        return MaterialPageRoute(builder: (_) => signUp());
      case '/loadingScreen':
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case '/homeScreen':
        return MaterialPageRoute(
            builder: (_) => StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return home();
                  } else {
                    return loginScreen();
                  }
                }));
      case '/contactAuthoritiesScreen':
        return MaterialPageRoute(builder: (_) => ContactAuthoritiesScreen());
      case '/contactsScreen':
        return MaterialPageRoute(builder: (_) => ContactsScreen());
      case '/settingsScreen':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/profileScreen':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/articlesScreen':
        return MaterialPageRoute(builder: (_) => NewsFeedPage2());
      case '/communityScreen':
        return MaterialPageRoute(builder: (_) => CommunityScreen());
      case '/newPostScreen':
        return MaterialPageRoute(builder: (_) => newPost());
      case '/cameraPageScreen':
        return MaterialPageRoute(builder: (_) => CameraPage());
      case '/resetPasswordScreen':
        return MaterialPageRoute(builder: (_) => forgotPassword());
      case '/commentCommunityScreen':
        if (args is Post) {
          return MaterialPageRoute(
              builder: (_) => commentCommunityScreen(post: args));
        }
        return _errorRoute();
      case '/addArticleScreen':
        if (args is Overlay) {
          return MaterialPageRoute(builder: (_) => NewsFeedPage2());
        }
        return _errorRoute();
      case '/removeArticleScreen':
        if (args is Article) {
          return MaterialPageRoute(builder: (_) => NewsFeedPage2());
        }
        return _errorRoute();
      // return ---
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Error Routing'),
          ),
          body: const Center(
            child: Text('Error Routing'),
          ));
    });
  }
}
