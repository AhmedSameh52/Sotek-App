import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/widgets/home.dart';
import 'package:solution_challenge_v1/widgets/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge_v1/widgets/themeManager.dart';

import '../main.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextStyle defaultStyle = const TextStyle(
      color: const Color.fromRGBO(76, 83, 101, 1), fontSize: 16.0);

  bool _isPasswordVisible = true;
  bool _rememberMe = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ThemeManager theme = ThemeManager();

  void _handleRemeberme(bool value) {
    _rememberMe = value;
    // SharedPreferences.getInstance().then(
    //   (prefs) {
    //     prefs.setBool("remember_me", value);
    //     prefs.setString('email', emailController.text);
    //     prefs.setString('password', passwordController.text);
    //   },
    // );
    setState(() {
      _rememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/login_screen_images/login_screenNew.png',
          ),
          fit: BoxFit.cover,
        )),
        // margin: EdgeInsets.fromLTRB(
        //     width * 0.07, height * 0.08, width * 0.07, height * 0.03),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: height * 0.06, left: width * 0.5),
                    child: Image.asset(
                      'assets/images/login_screen_images/sotek.png',
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                  child: TextFormField(
                    // TextField for the Email address
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(248, 225, 210, 1),
                      filled: true,
                      labelText: 'Email',
                      hintText: 'Please Enter your Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    //TextField for the Password
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(248, 225, 210, 1),
                      filled: true,
                      labelText: 'Password',
                      hintText: 'Please Enter your Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.65),
                  child: GestureDetector(
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(76, 83, 101, 1)),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/resetPasswordScreen');
                    },
                  ),
                ),
                // SizedBox(
                //   height: height * 0.006,
                // ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.11),
                  child: CheckboxListTile(
                    selectedTileColor: Colors.white,
                    tileColor: Color.fromRGBO(76, 83, 101, 1),
                    //Check Box for 'Remember me' Button
                    value: _rememberMe,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _rememberMe = value;
                        _handleRemeberme(value);
                      });
                    },
                    title: const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Color.fromRGBO(76, 83, 101, 1),
                        fontSize: 18,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                  // Sign in button, Used sizedbox to adjust the button's size
                  width: 340,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      signIn();
                      if (_rememberMe) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('email', emailController.text.trim());
                        prefs.setString(
                            'password', passwordController.text.trim());
                      }
                      Navigator.pushReplacementNamed(context, '/loadingScreen');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(231, 243, 244, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(245, 147, 138, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                RichText(
                  text: TextSpan(style: defaultStyle, children: <TextSpan>[
                    const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                    TextSpan(
                        style: TextStyle(
                            color: Color.fromRGBO(76, 83, 101, 1),
                            fontSize: 20),
                        text: 'Sign up!',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/signUpScreen');
                          }),
                  ]),
                )
              ]),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await userC.getUserDetails(emailController.text.trim());
      await userC.getAllContacts();
      print(currentApplicationUser.toString());
    } on FirebaseAuthException catch (e) {
      Navigator.pushReplacementNamed(context, '/loginScreen');
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
