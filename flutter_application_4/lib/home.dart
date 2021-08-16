// import 'dart:html';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/rec.dart';
import 'login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_application_4/login.dart';
import 'package:flutter_application_4/bn.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  // String t = u["name"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Ho(),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.greenAccent,
        ));
  }
}

class Ho extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Ho> {
  final CollectionReference u = FirebaseFirestore.instance.collection('Uu');
  var fu = FirebaseAuth.instance.currentUser;
  SearchBar searchBar;

  // final Image fi = FirebaseStorage.instance.ref().child(n).getData() as Image;
  var n = "";
  String m = '';
  String c = '';
  String imurl;
  bool issearch = false;
  var f;
  int index = 0;

  get mainAxisAlignment => null;

  @override
  // data();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // mainAxisAlignment: MainAxisAlignment.end,
          (!issearch)
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      issearch = !issearch;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    setState(() {
                      issearch = !issearch;
                    });
                  })
        ],
        // actions: [searchBar.getSearchAction(context)],
        title: !issearch
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signOut()
                                  .then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Login()));
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                              ));
                            }
                          },
                          child: Icon(
                            Icons.logout,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[950],
                    icon: Icon(Icons.search),
                    hintText: "Search Recipe",
                    hintStyle: TextStyle(color: Colors.white)),
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
      drawer: Drawer(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.greenAccent),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              // (_userProfile != null)
                              //     ? Image.network(_userProfile)
                              //     :
                              AssetImage("img/p.png"),
                          radius: 70.0,
                        ),
                        Positioned(
                            bottom: 10,
                            right: 12,
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () => uploadImage(),
                              icon: Icon(Icons.camera_alt_rounded),
                              iconSize: 25,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  " 📧 : $_userEmail",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              ListTile(
                title: Text(
                  " 👤 : $_userName",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              ListTile(
                title: Text(
                  " 🏡 : $_userCity",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),

      // body: Container(color: Colors.blueAccent),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         icon: Icon(Icons.home),
      //         onPressed: () => Home.routeName,
      //       ),
      //       label: 'Home',
      //       backgroundColor: Colors.black12,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //           icon: Icon(Icons.favorite), onPressed: () => Rec.routeName),
      //       label: 'Fvaorites',
      //       backgroundColor: Colors.black12,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //           color: Colors.greenAccent,
      //           icon: Icon(Icons.add),
      //           onPressed: () => Navigator.push(context,
      //               new MaterialPageRoute(builder: (context) => new Rec()))),
      //       label: 'New Recipe',
      //       backgroundColor: Colors.black,
      //     ),
      //   ],
      //   backgroundColor: Colors.black26,
      //   unselectedItemColor: Colors.greenAccent,
      //   selectedItemColor: Colors.greenAccent,
      // )
      bottomNavigationBar: Bnav(),
    );
  }

  var _userName = "";
  var _userEmail = "";
  var _userCity = "";
  // String _userProfile = "";

  Future<void> _getUD() async {
    FirebaseFirestore.instance
        .collection('Uu')
        .doc((FirebaseAuth.instance.currentUser.uid))
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()['Name'];
        _userEmail = value.data()['email'];
        _userCity = value.data()['City'];
        // _userProfile = value.data()['url'];
      });
    });
  }

  void initState() {
    super.initState();
    _getUD();
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    if (PermissionStatus.granted != null) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        var snapshot = await _storage.ref().child(_userName).putFile(file);
        if (_userName != null) {
          var snapshot = await _storage.ref().child(_userName).putFile(file);
          var downloadurl = await snapshot.ref.getDownloadURL();
          var fuu = FirebaseAuth.instance.currentUser;
          u.doc(fuu.uid).set({
            'url': downloadurl,
          });

          setState(() {
            imurl = downloadurl;
            f = file;
          });
        } else {
          print("No path received");
        }
      } else {
        print("Grant permissions and try again");
      }
    }
  }
}
