import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContactCards extends StatefulWidget {
  const ContactCards({super.key});

  @override
  State<ContactCards> createState() => _ContactCardsState();
}

class _ContactCardsState extends State<ContactCards> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Center(child: Text("data")));
  }
}
