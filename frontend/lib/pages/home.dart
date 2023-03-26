import 'package:bill_split/pages/PicturePage.dart';
import 'package:flutter/material.dart';

import 'widget/BaseAppBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: BaseAppBar()),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: const Text('Welcome',
                    style: TextStyle(
                        fontSize: 42,
                        color: Colors.black,
                        fontWeight: FontWeight.w700))),
            Container(
                child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lightGreen),
                    ),
                    child: const Text(
                      'Get Started!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PicturePage()),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
