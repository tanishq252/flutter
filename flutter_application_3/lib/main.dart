import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: ListView(
          children: [
            we,
            w1,
            ww,
            w2,
          ],
        ),
      ),
    );
  }
}

Widget we = Container(
  margin: const EdgeInsets.all(15),
  child: Column(
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Text(
              "Email",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter Your Email",
          )),
    ],
  ),
);

Widget w1 = Container(
  padding: const EdgeInsets.all(15),
  child: Column(
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Text(
              "Password",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter Your Password",
          )),
    ],
  ),
);

Widget ww = Container(
    padding: const EdgeInsets.all(25),
    child: SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Sign In'),
      ),
    ));

Widget w2 = Container(
  padding: const EdgeInsets.all(30),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Text("Forgot Password?"),
      ),
      Text("Join Now"),
    ],
  ),
);
