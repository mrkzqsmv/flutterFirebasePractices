import 'package:demo_project/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserPage extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const AddUserPage(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return CustomButton(
        buttonText: 'Add User Info',
        onTap: () {
          try {
            addUser();
            print('added user success');
          } catch (e) {
            print(e);
          }
        });
  }
}
