import 'package:bill_split/pages/AuthPage.dart';
import 'package:flutter/material.dart';
import 'widget/BaseAppBar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String userName = "";
  static String password = "";

  @override
  Widget build(BuildContext context) {
    return ContactFetch();
  }
}

class ContactFetch extends StatefulWidget {
  const ContactFetch({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<ContactFetch> {
// var to store
// onChanged callback
  String userName = "No Value Entered";
  String password = "No Value Entered";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BaseAppBar(headerStr: "Login")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text("Please enter your Venmo Information."),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              // ignore: unnecessary_const
              child: TextField(
                onChanged: (value) => userName = value,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UserName',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: TextField(
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightGreen,
                    shadowColor: Colors.black,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    print(userName);
                    print(password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthPage()),
                    );
                  },
                  child: Column(
                    children: [
                      const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ))
          ]),
    );
  }
}
