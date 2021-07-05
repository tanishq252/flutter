import 'package:flutter/material.dart';
import 'package:flutter_application_4/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Ho(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.greenAccent,
        ));
  }
}

class Ho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Login()));
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
              child: Icon(
                Icons.logout,
              ),
            ),
            Text("Logout")
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: Text("Welcome to Home Page",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
          ),
          Container(),
        ],
      ),
    );
  }
}
