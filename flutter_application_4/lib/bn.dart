import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/home.dart';
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
// import 'package:flutter_application_4/home.dart';
import 'package:flutter_application_4/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class Bnav extends StatefulWidget {
//   @override
//   _BnavState createState() => _BnavState();
// }

// class _BnavState extends State<Bnav> {
//   int _selectedIndex = 0;
//   final List<dynamic> _widgetOptions = [

//     Home(),
//     Rec(),
//     Rec(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//         // appBar: AppBar(
//         //     title: const Text('Flutter BottomNavigationBar Example'),
//         //     backgroundColor: Colors.green),
//         // body: Center(
//         //   child: _widgetOptions.elementAt(_selectedIndex),
//         // ),
//         body: _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: BottomNavigationBar(
//           onTap: _onItemTapped,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(

//                 icon: Icon(Icons.home),
//                 title: Text('Home'),
//                 backgroundColor: Colors.green),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite),
//                 title: Text('Search'),
//                 backgroundColor: Colors.yellow),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add),
//               title: Text('Profile'),
//               backgroundColor: Colors.blue,
//             ),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.black,
//           iconSize: 40,
//           elevation: 10,
//         ));
//   }
// }

class Bnav extends StatefulWidget {
  @override
  _BnavState createState() => _BnavState();
}

class _BnavState extends State<Bnav> {
  int _selectedIndex = 0;

  List<Widget> _wo = [
    Home(),
    Rec(),
    Rec(),
  ];

  void _onTap(int ind) {
    setState(() {
      _selectedIndex = ind;
    });
  }

  var b = 30.0;
  var c = 30.0;
  var d = 30.0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              iconSize: c,
              color: Colors.greenAccent,
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Home()));
                _onTap(0);
                setState(() {
                  c = 60.0;
                });
              },
            ),
            // backgroundColor: Colors.grey[800],
            label: "Home"),
        BottomNavigationBarItem(
            icon: IconButton(
              iconSize: d,
              color: Colors.greenAccent,
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new Rec()));
                _onTap(1);
                setState(() {
                  d = 60.0;
                });
              },
            ),
            label: "Favorites"),
        BottomNavigationBarItem(
          backgroundColor: Colors.grey,
          icon: IconButton(
            iconSize: b,
            color: Colors.greenAccent,
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => new Rec()));
              _onTap(2);
              setState(() {
                // _selectedIndex = 2;
                b = 60.0;
              });
            },
          ),
          label: "Add Recipe",
        ),
        // BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Home"),
        // BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add a recipe")
      ],
      elevation: 10,
      // currentIndex: _selectedIndex,
      // backgroundColor: b,
      unselectedLabelStyle: TextStyle(color: Colors.greenAccent),
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.greenAccent,
      // onTap: _onTap,
    );
  }
}
    // return CurvedNavigationBar(
    //   color: Colors.greenAccent,
    //   backgroundColor: Colors.black,
    //   buttonBackgroundColor: Colors.greenAccent,
    //   items: <Widget>[
    //     GestureDetector(
    //         child: Icon(Icons.home),
    //         onTap: () {
    //           Navigator.push(context,
    //               new MaterialPageRoute(builder: (context) => new Home()));
    //         }),
    //     GestureDetector(
    //         child: Icon(Icons.favorite),
    //         onTap: () {
    //           Navigator.push(context,
    //               new MaterialPageRoute(builder: (context) => new Rec()));
    //         }),
    //     GestureDetector(
    //         child: Icon(Icons.add),
    //         onTap: () {
    //           Navigator.push(context,
    //               new MaterialPageRoute(builder: (context) => new Rec()));
    //         }),

    //   ]

    //    );   //Handle button tap
  

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

