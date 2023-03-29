import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/main.dart';
import '../Model/Contact.dart';
import '../Model/languageTranslator.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  Language _language = Language();
  @override
  void initState() {
    super.initState();
  }

  getContacts() async {
    await userC.getAllContacts();
  }

  @override
  void dispose() {
    print(currentApplicationUser!.emergencyContacts.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
        stretchMaxHeight: 0.02,
        headerExpandedHeight: 0.01,
        title: Text(
          _language.tContacts(),
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
          ListView.separated(
            padding: EdgeInsets.only(top: 0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: currentApplicationUser!.emergencyContacts.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              final contact = currentApplicationUser!.emergencyContacts[index];
              return ListTile(
                title: Text(
                  contact.name,
                  style: TextStyle(
                    fontFamily: 'Figtree',
                    fontSize: 20,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  contact.phoneNumber,
                  style: TextStyle(
                    fontFamily: 'Figtree',
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await userC.deleteEmergencyContact(contact);
                    setState(() {});
                  },
                ),
              );
            },
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: isDarkMode
                  ? const Color.fromRGBO(255, 189, 183, 1)
                  : const Color.fromRGBO(246, 145, 138, 1),
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final nameController = TextEditingController();
                    final phoneController = TextEditingController();
                    return AlertDialog(
                      title: const Text('Add Contact'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          TextField(
                            controller: phoneController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Add'),
                          onPressed: () async {
                            if (nameController.text.trim().isNotEmpty &&
                                phoneController.text.trim().isNotEmpty) {
                              await userC.addEmergencyContact(Contact(
                                name: nameController.text.trim(),
                                phoneNumber: '+2${phoneController.text.trim()}',
                              ));
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/contactsScreen');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                // ignore: prefer_const_constructors
                                SnackBar(
                                  content: const Text(
                                      'Please enter a name and phone number.'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ]);
  }
}
