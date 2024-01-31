import 'package:demo_project/addUserPage.dart';
import 'package:demo_project/readUserInfoPage.dart';
import 'package:demo_project/widgets/customButton.dart';
import 'package:demo_project/widgets/customTextFormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestorePractices extends StatefulWidget {
  const CloudFirestorePractices({super.key});

  @override
  State<CloudFirestorePractices> createState() =>
      _CloudFirestorePracticesState();
}

class _CloudFirestorePracticesState extends State<CloudFirestorePractices> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    emailController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cloud Firestore Practices'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomTextFormFieldWidget(
                    controller: emailController, hintText: 'Email'),
                CustomTextFormFieldWidget(
                    controller: ageController, hintText: 'Age'),
                CustomTextFormFieldWidget(
                    controller: cityController, hintText: 'City'),
                CustomButton(
                    buttonText: 'Save info',
                    onTap: () async {
                      return addData();
                    }),
                const SizedBox(
                  height: 10,
                ),
                const AddUserPage('ss', 'sss', 20),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    buttonText: 'Read User Info Page',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ReadUserInfoPage(
                              docId: '1IQvbiyVzl6PJbfy8qI9'),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void addData() async {
  try {
    await FirebaseFirestore.instance.collection('users').add({
      'field1': 'value1',
      'field2': 'value2',
    });
    print('Data added successfully!');
  } catch (e) {
    print('Error adding data: $e');
  }
}
