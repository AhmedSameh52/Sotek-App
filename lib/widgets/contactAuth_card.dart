import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class ContactAuthCard extends StatefulWidget {
  final String title;
  final String text;
  final Color colour;

  const ContactAuthCard(
      @required this.title, @required this.text, @required this.colour);

  @override
  State<ContactAuthCard> createState() => _ContactAuthCardState();
}

class _ContactAuthCardState extends State<ContactAuthCard> {
  String number = '';
  String selectedText = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(15),
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: widget.colour,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.title,
              style: textStyleNormalMode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SelectableText(
              widget.text,
              style: textStyleNormalMode,
              textAlign: TextAlign.center,
              showCursor: false,
              onSelectionChanged: (selection, cause) {
                setState(() {
                  // selectedText = selection.textInside(widget.text);
                  int? x = int.tryParse(selection.textInside(widget.text));
                  //print(x);
                  if (x != null) {
                    number = selection.textInside(widget.text);
                    print(number);
                  }
                });
              },
              contextMenuBuilder: (context, editableTextState) {
                return AdaptiveTextSelectionToolbar(
                    anchors: editableTextState.contextMenuAnchors,
                    children: [
                      IconButton(
                          onPressed: () async {
                            final Uri url = Uri(scheme: 'tel', path: number);
                            await launchUrl(url);
                            editableTextState.hideToolbar();
                          },
                          icon: const Icon(Icons.phone)),
                      IconButton(
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: number));
                            editableTextState.hideToolbar();
                          },
                          icon: const Icon(Icons.copy))
                    ]);
              },
            ),
          )
        ],
      ),
    );
  }
}
