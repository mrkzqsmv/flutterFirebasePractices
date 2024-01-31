import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage extends StatefulWidget {
  const CloudStorage({super.key});

  @override
  State<CloudStorage> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<CloudStorage> {
  final storage = FirebaseStorage.instance;

  final storageRef = FirebaseStorage.instance.ref();

  // final imagesRef = storageRef.child('images');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cloud Storage'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
