import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/cloudStoragePractices.dart';
import 'package:demo_project/widgets/customButton.dart';
import 'package:flutter/material.dart';

class ReadUserInfoPage extends StatefulWidget {
  final String docId;
  const ReadUserInfoPage({super.key, required this.docId});

  @override
  State<ReadUserInfoPage> createState() => _ReadUserInfoPageState();
}

class _ReadUserInfoPageState extends State<ReadUserInfoPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Read User Info'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: users.doc(widget.docId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        print('ERROR OCCURED');
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        return Center(
                          child: Text(data.toString()),
                        );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  buttonText: 'Cloud storage',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CloudStorage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
