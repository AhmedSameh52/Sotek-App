import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:solution_challenge_v1/main.dart';
import '../Model/languageTranslator.dart';
import 'package:solution_challenge_v1/Model/map.dart';
import 'package:solution_challenge_v1/widgets/settings_screen.dart';

import 'contactAuthorities_screen.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  OverlayEntry? entryContactAuth_emergencyContacts;
  OverlayEntry? entryNearestHelpCenters;

  Language _language = Language();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowTitle: true,
      stretchMaxHeight: 0.02,
      headerExpandedHeight: 0.01,
      title: Text(
        "Sotek - صوتك",
        style: TextStyle(
          fontFamily: 'Figtree',
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      headerWidget: Container(),
      body: [
        ListView(
          padding: EdgeInsets.only(top: 0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 15.0), //To add space between widgets
            //Emergency Setup Button
            // if (true) contactAuth_emergencyContacts_overlay(true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    contactAuth_emergencyContacts_overlay(context);
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: isDarkMode
                            ? const AssetImage(
                                'assets/images/home_screen_images/emergency_bell_dark.png')
                            : const AssetImage(
                                'assets/images/home_screen_images/emergency_bell.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _language.tEmergencySetupAndContactAuthorities(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0), //To add space between widgets
            //Chat Bot Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cameraPageScreen');
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: isDarkMode
                            ? const AssetImage(
                                'assets/images/home_screen_images/camera_dark.png')
                            : const AssetImage(
                                'assets/images/home_screen_images/camera_light.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _language.tEmeregencyRecording(),
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            //Nearest Help Centers Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    nearestHelpCenters_overlay(context);
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: isDarkMode
                            ? const AssetImage(
                                'assets/images/home_screen_images/nearest_help_centers_dark.png')
                            : const AssetImage(
                                'assets/images/home_screen_images/nearest_help_centers.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _language.tNearestHelpCenters(),
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0), //To add space between widgets

            //Community Portal Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/communityScreen');
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: isDarkMode
                            ? const AssetImage(
                                'assets/images/home_screen_images/community_image_dark.png')
                            : const AssetImage(
                                'assets/images/home_screen_images/community_image.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _language.tCommunityPortal(),
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0), //To add space between widgets
            //Articles Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/articlesScreen');
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: const AssetImage(
                            'assets/images/home_screen_images/articlesIcon.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _language.tLatestNewsAndArticles(),
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0), //To add space between widgets
            //To add space between widgets
            //Settings Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settingsScreen');
                  },
                  child: Column(
                    children: [
                      Ink.image(
                        image: isDarkMode
                            ? const AssetImage(
                                'assets/images/home_screen_images/settings_dark.png')
                            : const AssetImage(
                                'assets/images/home_screen_images/settings.png'),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 150,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _language.tSettings(),
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0), //To add space between widgets
          ],
        )
      ],
    );
  }

  Future<void> contactAuth_emergencyContacts_overlay(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.fromLTRB(
              width * 0.1, height * 0.1, width * 0.1, height * 0.1),
          backgroundColor: isDarkMode
              ? Color.fromRGBO(50, 49, 49, 1)
              : Color.fromRGBO(241, 254, 255, 1),
          actions: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/contactsScreen');
                      },
                      child: Column(
                        children: [
                          Ink.image(
                            image: isDarkMode
                                ? const AssetImage(
                                    'assets/images/contactAuth_emergencyContacts_overlay/emergency-call_dark.png')
                                : const AssetImage(
                                    'assets/images/contactAuth_emergencyContacts_overlay/emergency-call.png'),
                            fit: BoxFit.contain,
                            width: width * 0.3,
                            height: height * 0.15,
                          ),
                          Text(
                            _language.tEmergencyContacts(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Figtree',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: width * 0.02),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, '/contactAuthoritiesScreen');
                      },
                      child: Column(
                        children: [
                          Ink.image(
                            image: const AssetImage(
                                'assets/images/contactAuth_emergencyContacts_overlay/contactAuthorities.png'),
                            fit: BoxFit.contain,
                            width: width * 0.3,
                            height: height * 0.15,
                          ),
                          Text(
                            _language.tContactAuthorities(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Figtree',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        );
      },
    );
  }

  Future<void> nearestHelpCenters_overlay(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.fromLTRB(
              width * 0.1, height * 0.1, width * 0.1, height * 0.1),
          backgroundColor: isDarkMode
              ? Color.fromRGBO(50, 49, 49, 1)
              : Color.fromRGBO(241, 254, 255, 1),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      language == "English"
                          ? SizedBox(height: height * 0.03)
                          : SizedBox(),
                      TextButton(
                        onPressed: () {
                          MapUtils.openMap('Police Station');
                        },
                        child: Column(
                          children: [
                            Ink.image(
                              image: isDarkMode
                                  ? const AssetImage(
                                      'assets/images/nearestHelpCenters_overlay/policeStation_dark.png')
                                  : const AssetImage(
                                      'assets/images/nearestHelpCenters_overlay/policeStation.png'),
                              fit: BoxFit.contain,
                              width: width * 0.3,
                              height: height * 0.15,
                            ),
                            Text(
                              _language.tPoliceStations(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.05),
                  TextButton(
                    onPressed: () {
                      MapUtils.openMap('Hospital');
                    },
                    child: Column(
                      children: [
                        Ink.image(
                          image: const AssetImage(
                              'assets/images/nearestHelpCenters_overlay/hospital.png'),
                          fit: BoxFit.contain,
                          width: width * 0.3,
                          height: height * 0.15,
                        ),
                        Text(
                          _language.tHospitals(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Figtree',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        MapUtils.openMap('National Council For Women');
                      },
                      child: Column(
                        children: [
                          Ink.image(
                            image: const AssetImage(
                                'assets/images/nearestHelpCenters_overlay/womenCouncil.png'),
                            fit: BoxFit.contain,
                            width: width * 0.3,
                            height: height * 0.15,
                          ),
                          Text(
                            _language.tNationalCouncilForWomen(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Figtree',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
