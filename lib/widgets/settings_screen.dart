import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:draggable_home/draggable_home.dart';

import 'package:solution_challenge_v1/main.dart';
import 'package:solution_challenge_v1/widgets/Community.dart';
import 'package:solution_challenge_v1/widgets/login_screen.dart';
import 'package:solution_challenge_v1/widgets/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/languageTranslator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  static const Color transparentColor = Color.fromRGBO(
      255, 255, 255, 0); //background color of avatar- its transparent
  bool darkModeToggle = false;
  OverlayEntry? entryChangeLanguage;
  Language _language = Language();

  @override
  void initState() {
    setState(() {
      _language.getLanguage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      headerExpandedHeight: 0.01,
      title: Text(
        _language.tSettings(),
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
        ListTile(
          leading: ClipRect(
            child: Image(
                image:
                    AssetImage("${currentApplicationUser!.getProfilePicture}")),
          ),
          title: Text(
            _language.tProfile(),
            style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/profileScreen');
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: isDarkMode
              ? const ClipRect(
                  child: Image(
                      image: AssetImage(
                          "assets/images/settings_screen_images/languageDarkMode.png")))
              : const ClipRect(
                  child: Image(
                      image: AssetImage(
                          "assets/images/settings_screen_images/language.png")),
                ),
          title: Text(
            _language.tChangelanguage(),
            style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
          ),
          onTap: () {
            changeLanguage(context);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: const ClipRect(
            child: Image(
                height: 50,
                width: 50,
                image: AssetImage(
                    "assets/images/settings_screen_images/logout_final.png")),
          ),
          title: Text(
            " ${_language.tSignOut()}",
            style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
          ),
          onTap: () {
            _SignOutDialog();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 5,
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: Color.fromRGBO(246, 167, 160, 1),
        ),
        SwitchListTile(
          activeColor: const Color.fromRGBO(246, 167, 160, 1),
          value: themeManager.themeMode == ThemeMode.dark ? true : false,
          secondary: const ClipRect(
            child: Image(
                image: AssetImage(
                    "assets/images/settings_screen_images/dark_mode.png")),
          ),
          title: Text(
            _language.tDarkMode(),
            style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
          ),
          onChanged: (bool value) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              isDarkMode = value;

              prefs.setBool('mode', isDarkMode);
              print(isDarkMode);
              themeManager.toggleTheme(isDarkMode);
            });
          },
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Future<bool> _SignOutDialog() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isDarkMode
                ? const Color.fromRGBO(50, 49, 49, 1)
                : const Color.fromRGBO(241, 254, 255, 1),
            title: Text(
              'Are you sure?',
              style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
            ),
            content: Text(
              'Do you want to sign out',
              style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
                ),
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, '/loginScreen');
                }, //SIGN OUT
                child: Text(
                  'Yes',
                  style: isDarkMode ? textStyleDarkMode : textStyleNormalMode,
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> changeLanguage(BuildContext context) {
    String currentOption = language;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(5),
            scrollable: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: isDarkMode
                ? const Color.fromRGBO(50, 49, 49, 1)
                : const Color.fromRGBO(241, 254, 255, 1),
            content: StatefulBuilder(
              builder: (context, _setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile(
                      activeColor: const Color.fromRGBO(246, 145, 138, 1),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: 'English',
                      groupValue: currentOption,
                      onChanged: (val) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        _setState(() {
                          currentOption = val.toString();
                          language = currentOption;
                          prefs.setString('changeLanguage', language);

                          var email = prefs.getString('email');
                          _language.setLanguage(language);
                          email == null
                              ? FirebaseAuth.instance.signOut()
                              : Null;
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(
                              context, '/loginScreen');
                          Phoenix.rebirth(context);
                        });
                      },
                      title: Text(
                        "English",
                        style: isDarkMode
                            ? textStyleDarkMode
                            : textStyleNormalMode,
                      ),
                    ),
                    RadioListTile(
                      activeColor: const Color.fromRGBO(246, 145, 138, 1),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: 'Arabic',
                      groupValue: currentOption,
                      onChanged: (val) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        _setState(() {
                          currentOption = val.toString();
                          language = currentOption;
                          prefs.setString('changeLanguage', language);
                          _language.setLanguage(language);
                          Phoenix.rebirth(context);
                        });
                      },
                      title: Text(
                        "Arabic",
                        style: isDarkMode
                            ? textStyleDarkMode
                            : textStyleNormalMode,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
