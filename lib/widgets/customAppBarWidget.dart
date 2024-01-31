import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final String appBarTitle;
  const CustomAppBarWidget({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
    );
  }
  
  @override
  Size get preferredSize => throw UnimplementedError();
}
