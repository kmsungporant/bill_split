import 'package:flutter/material.dart';

import 'widget/BaseAppBar.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BaseAppBar(headerStr: "Contact Info")),
    );
  }
}
