import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/Model/languageTranslator.dart';
import 'package:solution_challenge_v1/widgets/home.dart';
import '../Model/languageTranslator.dart';
import '../main.dart';
import './contactAuth_card.dart';

class ContactAuthoritiesScreen extends StatefulWidget {
  @override
  State<ContactAuthoritiesScreen> createState() =>
      _ContactAuthoritiesScreenState();
}

class _ContactAuthoritiesScreenState extends State<ContactAuthoritiesScreen> {
  Language _language = Language();

  @override
  Widget build(BuildContext context) {
    Language _language = Language();
    return DraggableHome(
        stretchMaxHeight: 0.02,
        headerExpandedHeight: 0.01,
        alwaysShowLeadingAndAction: true,
        alwaysShowTitle: true,
        title: Text(
          _language.tContactAuthoritiesAppBar(),
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
            padding: const EdgeInsets.only(top: 0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              ContactAuthCard(_language.tEmergency(), "122",
                  const Color.fromRGBO(244, 201, 251, 1)),
              ContactAuthCard(_language.tAmbulance(), "123",
                  const Color.fromRGBO(244, 201, 251, 1)),
              ContactAuthCard(
                  _language
                      .tNationalAuthorityforviolenceagainstwomeninMinistryofinterior(),
                  "01126977444\n01126977333\n01126977222",
                  const Color.fromRGBO(244, 201, 251, 1)),
              ContactAuthCard(
                  _language.tNationalCouncilforWomen(),
                  "Hotline: 15115\nWhatsApp: 01007525600",
                  const Color.fromRGBO(228, 253, 255, 1)),
              ContactAuthCard(_language.tMotherandchildhealthline(),
                  "Hotline: 16021", const Color.fromRGBO(224, 231, 255, 1)),
              ContactAuthCard(
                  _language.tChildhelpline(),
                  " Hotline: 16000\nWhatsapp: 01102121600",
                  const Color.fromRGBO(145, 207, 255, 1)),
              ContactAuthCard(
                  _language.tMetroharassmenthotline(),
                  "0225747295\nHotline: 16048",
                  const Color.fromRGBO(252, 224, 241, 1))
            ],
          ),
        ]);
  }
}
