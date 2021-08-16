// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/home.dart';
import 'package:flutter_application_4/login.dart';
import 'package:flutter_application_4/bn.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

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

import 'package:async_button_builder/async_button_builder.dart';

class Rec extends StatelessWidget {
  @override
  static const routeName = '/rec';
  Widget build(BuildContext context) {
    return MaterialApp(
        home: R(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.greenAccent,
        ));
  }
}

var fu = FirebaseAuth.instance.currentUser;

Future<String> getRegisterUserData({String userID}) async {
  String name;
  String mail;
  String city;

  FirebaseFirestore.instance.collection('Uu').doc(fu.uid).get().then(
    (datasnapshot) {
      if (datasnapshot.exists) {
        name = datasnapshot.data()['Name'];
        mail = datasnapshot.data()['email'];
        city = datasnapshot.data()['City'];
      } else {
        return "Loading...";
      }
    },
  );
}

class R extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<R> {
  var imu = "";
  String _dropDownValue;
  bool _gallery = true;

  final CollectionReference use =
      FirebaseFirestore.instance.collection('Recipe');
  TextEditingController name_recipe = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController steps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
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
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.white30, Colors.greenAccent]),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0),
              topLeft: Radius.circular(80.0),
              topRight: Radius.circular(80.0),
            ),
          ),
          child: Text(
            "Hey Chefs 👨🏻‍🍳👩🏼‍🍳 !! \n\nWelcome!!\n\nHere You can add the details of your recipe and also upload image of the Final Dish !!\n\n You can upload recipe without image but it will be less attractive",
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Column(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           child: Text(
        //             "Choose Cuisine Type :",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //         Container(
        //           padding: EdgeInsets.fromLTRB(100, 50, 100, 20),
        //           child: DropdownButton(
        //             hint: _dropDownValue == null
        //                 ? Text('Indian')
        //                 : Text(
        //                     _dropDownValue,
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //             isExpanded: true,
        //             iconSize: 30.0,
        //             style: TextStyle(color: Colors.white),
        //             items: [
        //               'Indian',
        //               'Japanese',
        //               'Italian',
        //               'Chinese',
        //               'American'
        //             ].map(
        //               (val) {
        //                 return DropdownMenuItem<String>(
        //                   value: val,
        //                   child: Text(val),
        //                 );
        //               },
        //             ).toList(),
        //             onChanged: (val) {
        //               setState(
        //                 () {
        //                   _dropDownValue = val;
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        Container(
          padding: EdgeInsets.fromLTRB(100, 50, 100, 20),
          child: DropdownButton(
            hint: _dropDownValue == null
                ? Text('Indian')
                : Text(
                    _dropDownValue,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.white),
            items: ['Indian', 'Japanese', 'Italian', 'Chinese', 'American'].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _dropDownValue = val;
                },
              );
            },
          ),
        ),

        IconButton(
            icon: Icon(
              Icons.upload_rounded,
              size: 50,
              color: Colors.greenAccent,
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Select how to take image'),
                      content: const Text('Camera or Gallery?'),
                      actions: <Widget>[
                        
                        IconButton(
                            icon: Icon(Icons.camera),
                            onPressed: () => {
                                  setState(() {
                                    _gallery = false;
                                    uploadImage();
                                    Navigator.pop(context, "Ok");
                                  })
                                }),
                        IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () => {
                                  setState(() {
                                    _gallery = true;
                                    uploadImage();
                                    Navigator.pop(context, "Ok");
                                  })
                                }),
                      ],
                    ))

            // ScaffoldMessenger(
            //         child: Row(
            //       children: [
            //         IconButton(
            //             icon: Icon(Icons.camera),
            //             onPressed: () => {
            //                   setState(() {
            //                     _gallery = false;
            //                     uploadImage();
            //                   })
            //                 }),
            //         IconButton(
            //             icon: Icon(Icons.image),
            //             onPressed: () => {
            //                   setState(() {
            //                     _gallery = true;
            //                     uploadImage();
            //                   })
            //                 }),
            //       ],
            //     )
            //     )
            ),
        Container(
          padding: EdgeInsets.fromLTRB(100, 50, 100, 30),
          alignment: Alignment.center,
          child: Text(
            "CLick above icon to upload your Recipe image",
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          margin: EdgeInsets.all(20),
          height: 2 * 30.0,
          child: TextField(
            maxLines: 2,
            controller: name_recipe,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.emoji_food_beverage),
                hintText: "Name of your Recipe",
                fillColor: Colors.grey[700],
                filled: true,
                labelText: "Name of your Recipe",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ))),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          height: 4 * 30.0,
          child: TextField(
            controller: ingredients,
            maxLines: 4,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.food_bank_rounded),
                labelText: "Ingredients",
                fillColor: Colors.grey[700],
                filled: true,
                hintText: "All the Ingredients included in your recipe",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ))),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          height: 12 * 30.0,
          child: TextField(
            controller: steps,
            maxLines: 12,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.set_meal),
                labelText: "Steps Followed",
                fillColor: Colors.grey[700],
                filled: true,
                hintText:
                    "Explaining your procedure may help others\nExplain in maximum 10 steps",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ))),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[850], width: 80),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(120.0),
              bottomRight: Radius.circular(120.0),
              topLeft: Radius.circular(120.0),
              topRight: Radius.circular(120.0),
            ),
            gradient: LinearGradient(
              colors: [Colors.white30, Colors.greenAccent],
            ),
          ),
          padding: EdgeInsets.all(0),
          child: AsyncButtonBuilder(
            // child: Center(
            child: Text(
              'Click Here To Submit',
              style: TextStyle(
                decorationColor: Colors.green,

                // backgroundColor: Colors.greenAccent,
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.lightGreen,
              ),
              textAlign: TextAlign.justify,
              // ),
            ),
            onPressed: () async {
              await Future.delayed(Duration(seconds: 6)).then((value) async {
                if (name_recipe.text.isEmpty ||
                    ingredients.text.isEmpty ||
                    steps.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Improper Input'),
                            content: const Text(
                                'You have not entered the details properly\nPlease enter details again'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text(
                  //       'Please enter details properly else the recipe will not be added'),
                  // ));
                } else {
                  var firebaseuser = FirebaseAuth.instance.currentUser;
                  await use.doc(firebaseuser.uid).set({
                    "Chef Name": _userName,
                    "Cuisine": _dropDownValue,
                    "Recipe Name": name_recipe.text,
                    "Ingredients": ingredients.text,
                    "Procedure": steps.text,
                    "url": imu,
                  });
                }
              });
            },
            builder: (context, child, callback, _) {
              return TextButton(
                child: child,
                onPressed: callback,
              );
            },
          ),
        ),
      ]),
      bottomNavigationBar: Bnav(),
    );
  }

  var _userName = "";
  // var _userEmail = "";
  // var _userCity = "";
  // String _userProfile = "";

  Future<void> _getUD() async {
    FirebaseFirestore.instance
        .collection('Uu')
        .doc((FirebaseAuth.instance.currentUser.uid))
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()['Name'];
        // _userEmail = value.data()['email'];
        // _userCity = value.data()['City'];
        // _userProfile = value.data()['url'];
      });
    });
  }

  void initState() {
    super.initState();
    _getUD();
  }

  Future uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    var fuu = FirebaseAuth.instance.currentUser;
    PickedFile image;
    if (PermissionStatus.granted != null) {
      image = (_gallery)
          ? (_picker.getImage(source: ImageSource.gallery))
          : (await _picker.getImage(source: ImageSource.camera));
      // (_gallery)
      //     ? (image = await _picker.getImage(source: ImageSource.gallery))
      //     : (image = await _picker.getImage(source: ImageSource.camera));
      var file = File(image.path);
      if (image != null) {
        var snapshot = await _storage.ref().child(fuu.uid).putFile(file);
        if (fuu.uid != null) {
          // var snapshot = await _storage.ref().child(fuu.uid).putFile(file);
          var downloadurl = await snapshot.ref.getDownloadURL();
          setState(() {
            imu = downloadurl;
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
