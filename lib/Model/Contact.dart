import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  late String name;
  late String phoneNumber;
  final String? contactID;
  Contact({required this.name, required this.phoneNumber, this.contactID});

  toJson() {
    return {
      "name": name,
      "phone number": phoneNumber,
      "contact id": contactID,
    };
  }

  factory Contact.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Contact(
      name: data["name"],
      phoneNumber: data["phone number"],
      contactID: document.id,
    );
  }
}
