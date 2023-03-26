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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Orders",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          for (var i = 0; i < currBill.items.length; i++)
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.only(top: 3),
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(20),
                    shadowColor: Colors.black,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        currBill.items[i].name,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        currBill.items[i].price.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
