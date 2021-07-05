import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/home.dart';
import 'package:flutter_application_4/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Signup.routeName: (ctx) => Signup(),
        Login.routeName: (ctx) => Login(),
        Home.routeName: (ctx) => Home(),
      },
      home: Signup(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyanAccent,
      ),
    );
  }
}

class Signup extends StatelessWidget {
  Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();

  final CollectionReference users = FirebaseFirestore.instance.collection('Uu');

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          return Scaffold(
            body: ListView(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    "Signup Page",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                          autofocus: true,
                          controller: name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            hintText: "Enter Your Name",
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                          autofocus: true,
                          controller: city,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home_rounded),
                            labelText: 'City',
                            border: OutlineInputBorder(),
                            hintText: "Enter Your City",
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                          autofocus: true,
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: 'Email',
                            hintText: "Enter Your Password",
                            border: OutlineInputBorder(),
                            //hintText: "Enter Your Email",
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                          obscureText: true,
                          autofocus: true,
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_rounded),
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            hintText: "Enter Your Password",
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("You have not enterd the details")));
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .then((value) async {
                              var firebaseUser = //Getting the information of the current user Logged in
                                  FirebaseAuth.instance.currentUser;
                              await users
                                  .doc(firebaseUser
                                      .email) //Using the set Method instead of the add method to give the document a unique name same as the UID of the current user
                                  .set({
                                //This will simply add the data to the database in the document with the unique document name as the UID of the user
                                'email': email
                                    .text, //Here the thing to be noted is that the add method gives the document a auto/random name or id but set method is used to give a specific unique name.
                                'Name': name
                                    .text, //This helps in actually integrating the authentication and the Firestore perfectly in sync and both things have a common UID as the particular user

                                'City': city.text
                              });
                              Navigator.of(context).pushReplacementNamed(Login
                                  .routeName); //Navigating to the UserDetails Page
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        }
                      },
                      child: const Text('Sign up'),
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
                          "Already have an Account?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Login.routeName);
                          },
                          child: Text(
                            "  Login",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
