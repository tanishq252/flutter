import 'package:flutter/material.dart';
import 'package:flutter_application_4/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class Test {}

class Login extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: H(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyanAccent,
        ));
  }
}

class H extends StatelessWidget {
  Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          var outlineInputBorder = OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(120.0),
              bottomRight: Radius.circular(120.0),
              topLeft: Radius.circular(120.0),
              topRight: Radius.circular(120.0),
            ),
          );
          return Scaffold(
            body: ListView(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    "Login Page",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 200,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: TextField(
                      controller: email,
                      autofocus: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(120.0),
                              bottomRight: Radius.circular(120.0),
                              topLeft: Radius.circular(120.0),
                              topRight: Radius.circular(120.0),
                            ),
                          ),
                          hintText: "Enter Your Email",
                          labelText: "Email")),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                      obscureText: true,
                      controller: password,
                      autofocus: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: outlineInputBorder,
                          hintText: "Enter Your Password",
                          labelText: "Password")),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(
                                          color: Colors.greenAccent,
                                          width: 2.0)))),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter details'),
                          ));
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        }
                      },
                    ),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Account ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Signup()));
                          },
                          child: Text(
                            "   Signup",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
