import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/ApplicationUser.dart';
import 'package:solution_challenge_v1/Model/languageTranslator.dart';
import 'package:solution_challenge_v1/main.dart';
import 'package:solution_challenge_v1/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color transparentColor = Color.fromRGBO(255, 255, 255, 0);
  OverlayEntry? entryChangeEmail;
  OverlayEntry? entryEmailVerification;
  OverlayEntry? entryChangeName;
  OverlayEntry? entryChangePassword;

  TextEditingController username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmNewPassword = TextEditingController();

  Language _language = Language();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
        headerExpandedHeight: 0.01,
        title: Text(
          _language.tProfile(),
          style: TextStyle(
            fontFamily: 'Figtree',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        alwaysShowTitle: true,
        headerWidget: Container(
          child: Center(
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ],
            ),
          ),
        ),
        body: [
          ListView(
            padding: EdgeInsets.only(top: 0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            chooseProfileImageOverlay(context);
                          },
                          child: Ink.image(
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  currentApplicationUser!.getProfilePicture))),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${currentApplicationUser!.username}",
                        style: isDarkMode
                            ? textStyleDarkMode
                            : textStyleNormalMode,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: isDarkMode
                    ? const ClipRect(
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "assets/images/proflie_screen_images/signatureDarkMode.png"),
                        ),
                      )
                    : const ClipRect(
                        child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage(
                            "assets/images/proflie_screen_images/signature (Custom).png"),
                      )),
                title: Text(
                  _language.tChangeName(),
                  style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
                ),
                onTap: () {
                  changeName(context);
                },
              ),
              ListTile(
                leading: isDarkMode
                    ? const ClipRect(
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "assets/images/proflie_screen_images/passwordDarkMode.png"),
                        ),
                      )
                    : const ClipRect(
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(
                              "assets/images/proflie_screen_images/lock.png"),
                        ),
                      ),
                title: Text(
                  _language.tChangePassword(),
                  style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
                ),
                onTap: () {
                  changePassword_overlay(context);
                },
              ),
            ],
          ),
        ]);
  }

  Future<void> changePassword_overlay(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Current Password',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _password,
                  //TextField for the Password

                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Current Password',
                    hintText: 'Please Enter your current Password',
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter New Password',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _newPassword,
                  //TextField for the Password

                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'New Password',
                    hintText: 'Please Enter your new Password',
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Pasword',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _confirmNewPassword,
                  //TextField for the Password

                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter New Password Again',
                    hintText: 'Please Confirm your new Password',
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                //SizedBox(height: height * 0.02),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 145, 138, 1),
            actions: <Widget>[
              SizedBox(
                // Sign in button, Used sizedbox to adjust the button's size
                width: 340,
                height: 65,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_newPassword.text.trim() ==
                        _confirmNewPassword.text.trim()) {
                      userC.changePassword(_newPassword.text.trim());
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> changeName(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              children: [
                Text(
                  "Enter New Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(248, 225, 210, 1),
                    filled: true,
                    labelText: 'Enter new name',
                    hintText: 'Please Enter new desired name',
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(248, 225, 210, 1)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.02,
                ),

                //SizedBox(height: height * 0.03,),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(246, 145, 138, 1),
            actions: <Widget>[
              SizedBox(
                // Sign in button, Used sizedbox to adjust the button's size
                width: 340,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    userC.changeUsername(username.text.trim());
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> chooseProfileImageOverlay(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // insetPadding: EdgeInsets.fromLTRB(
            //     width * 0.1, height * 0.1, width * 0.1, height * 0.1),
            backgroundColor: Color.fromRGBO(224, 231, 255, 20),
            actions: <Widget>[
              SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/1.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/1.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/2.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/2.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/3.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/3.png'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/4.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/4.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/5.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/5.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/6.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/6.png'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/7.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/7.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/8.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/8.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/9.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/9.png'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/10.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/10.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/11.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/11.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userC.changePofilePicture(
                              'assets/images/avatars/12.png');
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(
                              context, '/profileScreen');
                        },
                        child: Ink.image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/avatars/12.png'),
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ]);
      },
    );
  }
}
