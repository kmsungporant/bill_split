import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  BaseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Bill Split"),
      backgroundColor: Colors.lightGreen[100]!,
      automaticallyImplyLeading: true,
    );
  }
}
