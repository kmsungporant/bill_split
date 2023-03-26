import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  String headerStr = "Bill Split";
  BaseAppBar({super.key, required this.headerStr});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(headerStr),
      backgroundColor: Colors.brown,
      automaticallyImplyLeading: true,
    );
  }
}
