import 'package:bill_split/models/Item.dart';
import 'package:bill_split/pages/widget/Food.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/Bill.dart';
import 'widget/BaseAppBar.dart';

class Contacts extends StatelessWidget {
  late Bill currBill;
  Contacts({super.key, required this.currBill});

// Map<String, dynamic> food = jsonDecode(currBill.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BaseAppBar(headerStr: "Upload Receipt")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i = 0; i < currBill.items.length; i++)
            SizedBox(
                width: 200.0,
                height: 100.0,
                child: Card(
                    child: Text(currBill.items[i].name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center)))
        ],
      ),
      
    );
  }
}
