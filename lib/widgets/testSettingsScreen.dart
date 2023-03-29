import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';

import 'package:solution_challenge_v1/widgets/profile_screen.dart';

class BackupSettingsScreen extends StatefulWidget {
  const BackupSettingsScreen({super.key});

  @override
  State<BackupSettingsScreen> createState() => _BackupSettingsScreenState();
}

class _BackupSettingsScreenState extends State<BackupSettingsScreen> {
  static const Color transparentColor = Color.fromRGBO(
      255, 255, 255, 0); //background color of avatar- its transparent
  bool darkModeToggle = false;
  OverlayEntry? entryChangeLanguage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideChangeLanguage,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: transparentColor,
                backgroundImage: AssetImage(
                    "assets/images/settings_screen_images/profile.png"),
              ),
              title: const Text("Profile"),
              onTap: () {
                hideChangeLanguage();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: transparentColor,
                backgroundImage: AssetImage(
                    "assets/images/settings_screen_images/language.png"),
              ),
              title: const Text("Change language"),
              onTap: () {
                _buildDialogItem(Languages.english);
                _openLanguagePickerDialog();
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: transparentColor,
                backgroundImage: AssetImage(
                    "assets/images/settings_screen_images/logout-red.png"),
              ),
              title: const Text("Sign out"),
              onTap: () {
                hideChangeLanguage();
                _SignOutDialog();
              },
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SwitchListTile(
              secondary: const CircleAvatar(
                backgroundColor: transparentColor,
                backgroundImage: AssetImage(
                    "assets/images/settings_screen_images/dark-mode 3.png"),
              ),
              title: const Text("Dark mode"),
              onChanged: (bool value) {},
              value: false,
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<bool> _SignOutDialog() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //overlay1 is change language overlay
  void showChangeLanguage() {
    entryChangeLanguage = OverlayEntry(
      builder: (context) => Positioned(
        child: changeLanguage(),
      ),
    );
    final overlay = Overlay.of(context);
    overlay.insert(entryChangeLanguage!);
  }

  void hideChangeLanguage() {
    entryChangeLanguage?.remove();
    entryChangeLanguage = null;
  }

  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );
  Language _selectedDialogLanguage = Language.fromIsoCode('en');
  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                languages: [Languages.arabic, Languages.english],
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      print(_selectedDialogLanguage.name);
                      print(_selectedDialogLanguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );
  Widget changeLanguage() {
    int _value = 1;
    final PreferredSizeWidget appBar =
        AppBar(); //we made appBar as a variable to use its properties in adapting the ui down below
    final availabelHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final availabelWidth = MediaQuery.of(context).size.width;

    return Container(
      width: availabelWidth * 0.05,
      height: availabelHeight * 0.03,
      child: Card(
        margin: EdgeInsets.fromLTRB(
            availabelWidth * 0.05,
            availabelHeight * 0.3,
            availabelWidth * 0.05,
            availabelHeight * 0.6),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        color: const Color.fromRGBO(224, 231, 255, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              activeColor: const Color.fromRGBO(253, 135, 221, 1),
              controlAffinity: ListTileControlAffinity.trailing,
              value: 1,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  _value = val!;
                });
              },
              title: const Text("English"),
            ),
            RadioListTile(
              activeColor: const Color.fromRGBO(253, 135, 221, 1),
              controlAffinity: ListTileControlAffinity.trailing,
              value: 2,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  _value = val!;
                });
              },
              title: const Text("Arabic"),
            ),
          ],
        ),
      ),
    );
  }
}
