import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:solution_challenge_v1/Model/ApplicationUser.dart';
import 'package:solution_challenge_v1/widgets/login_screen.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  TextStyle defaultStyle = const TextStyle(color: Colors.black, fontSize: 16.0);
  TextStyle linkStyle =
      const TextStyle(color: Color.fromRGBO(253, 135, 221, 1));

  final _emailAddresscontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future SignUpUser() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailAddresscontroller.text.trim(),
          password: _passwordController.text.trim());

      ApplicationUser au = ApplicationUser(
          username: _nameController.text.trim(),
          email: _emailAddresscontroller.text.trim(),
          likedPosts: [],
          likedComments: [],
          profilePicture: "assets/images/avatars/8.png");
      FirebaseFirestore.instance.collection('users').add(au.toJson());
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/signUp_screen_images/Sign_up.png',
            ),
            fit: BoxFit.fill,
          )),
          // margin: EdgeInsets.fromLTRB(
          //     width * 0.03, height * 0.01, width * 0.03, height * 0.01),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  top: height * 0.008, right: width * 0.6, left: width * 0.05),
              child: Image.asset(
                'assets/images/signUp_screen_images/AddPP.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    child: TextFormField(
                      // TextField for the Email address
                      controller: _nameController,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(248, 225, 210, 1),
                        filled: true,
                        labelText: 'Name',
                        hintText: 'Please Enter your Name',
                        prefixIcon: const Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(248, 225, 210, 1)),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.004),
                  const Text(
                    'You can generate fake names',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    // TextField for the Email address
                    controller: _emailAddresscontroller,
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
                  SizedBox(
                    height: height * 0.07,
                  ),
                  TextFormField(
                    obscureText: _isPasswordVisible,
                    controller: _passwordController,
                    //TextField for the Password
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(248, 225, 210, 1),
                      filled: true,
                      labelText: 'Password',
                      hintText: 'Please Enter your Password',
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
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
                  SizedBox(
                    height: height * 0.07,
                  ),
                  TextFormField(
                    obscureText: _isConfirmPasswordVisible,
                    // TextField for the Email address
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(248, 225, 210, 1),
                      filled: true,
                      labelText: 'Confirm Password',
                      hintText: 'Please re-enter your password',
                      prefixIcon: const Icon(Icons.check),
                      enabledBorder: OutlineInputBorder(
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
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  // TextFormField(
                  //   // TextField for the Email address
                  //   controller: _phoneNumberController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Phone Number',
                  //     hintText: 'Please Enter Your Phone Number',
                  //     prefixIcon: const ImageIcon(AssetImage(
                  //         'assets/images/signUp_screen_images/phoneResized.png')),
                  //     border: OutlineInputBorder(
                  //       borderSide: const BorderSide(width: 2),
                  //       borderRadius: BorderRadius.circular(18),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  SizedBox(
                    // Sign in button, Used sizedbox to adjust the button's size
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        SignUpUser();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacementNamed(context,
                            '/loginScreen'); // CHANGE IT INTO LOADING SCREEN A.S
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(246, 145, 138, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // SizedBox(
                  //   // Sign in button, Used sizedbox to adjust the button's size
                  //   width: 300,
                  //   height: 66,
                  //   child: ElevatedButton(
                  //     child: Row(
                  //       children: [
                  //         Image.asset(
                  //           'assets/images/signUp_screen_images/google.png',
                  //           width: 40,
                  //           height: 40,
                  //           fit: BoxFit.cover,
                  //         ),
                  //         SizedBox(
                  //           width: height * 0.015,
                  //         ),
                  //         Text(
                  //           'Connect with google',
                  //           textAlign: TextAlign.right,
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor:
                  //             const Color.fromRGBO(253, 135, 221, 1),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30.0),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
