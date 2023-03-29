// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/ApplicationUser.dart';
import 'package:solution_challenge_v1/Model/languageTranslator.dart';
import 'package:solution_challenge_v1/widgets/home.dart';
import 'package:solution_challenge_v1/widgets/loadingScreen.dart';
import 'package:solution_challenge_v1/widgets/login_screen.dart';
import 'package:solution_challenge_v1/widgets/profile_screen.dart';
import 'package:solution_challenge_v1/widgets/routeGenerator.dart';
import 'package:solution_challenge_v1/widgets/signup_screen.dart';
import 'package:solution_challenge_v1/widgets/splashScreen.dart';
import './widgets/contactAuthorities_screen.dart';
import './widgets/settings_screen.dart';
import 'package:solution_challenge_v1/widgets/themeConstants.dart';
import 'package:solution_challenge_v1/widgets/themeManager.dart';
import './widgets/contacts.dart';
import 'firebase/admin.dart';
import 'Model/post.dart';
import 'firebase/userController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

String language = 'English';
var textStyleDarkMode = const TextStyle(
    fontFamily: 'Figtree',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white);
var textStyleNormalMode = const TextStyle(
    fontFamily: 'Figtree',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black);
var textAppBar = const TextStyle(
    fontFamily: 'Figtree',
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.white);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await userC.getAllPosts();
  await changeMode();

  runApp(Phoenix(child: MyApp()));
}

Future<void> changeMode() async {
  Language _language = Language();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var mode = prefs.getBool('mode').toString();
  isDarkMode = mode == 'false' ? false : true;
  var changeLanguage = prefs.getString('changeLanguage').toString();
  language = changeLanguage;
  _language.setLanguage(language);
  themeManager.toggleTheme(isDarkMode);
}

late bool isDarkMode = false;

bool isAdmin =
    currentApplicationUser!.email == "ahmed@gmail.com" ? true : false;
userController userC = userController('email', 'password');
ThemeManager themeManager = ThemeManager();
List<Post> tempPosts = userC.allPosts;
Admin a1 = Admin();
ApplicationUser? currentApplicationUser;
ValueNotifier isLoadingNotifier = ValueNotifier(false);
List<Post> allPosts = [];
late TwilioFlutter twilioFlutter;

Future<List<Map>> getPosts() async {
  // Get docs from collection reference
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('posts').get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  return allData;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeManager.themeMode,
      // Define your themes here
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenrator.generateRoute,
    );
  }
}
