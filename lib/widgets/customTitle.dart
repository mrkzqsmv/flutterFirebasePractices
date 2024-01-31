import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.amberAccent,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
