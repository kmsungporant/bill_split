import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  String headerStr = "Bill Split";
  BaseAppBar({super.key, required this.headerStr});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(headerStr, style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.lightGreen[100],
      automaticallyImplyLeading: true,
    );
  }
}
