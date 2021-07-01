import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Developer',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SAMBHAJI PARK"),
        ),
        body: ListView(
          children: [
            Image.asset(
              'im/f.jpg',
              width: 600,
              height: 250,
              fit: BoxFit.cover,
            ),
            titleSelection,
            btSl,
            t,
          ],
        ),
      ),
    );
  }
}

// Here we created our own widget and then implemented in our Myapp

Widget titleSelection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
          /*consider the whole container as collection of the texts one below another*/
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*This container contains the main text as in th UI*/
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Sambhaji Park",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          Text(
            'ShivajiNagar, Pune-5',
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
        ],
      )),

      /*The next part is the icon of star and text at the right*/
      Icon(
        Icons.star_rounded,
      ),
      Text('5')
    ],
  ),
);

/* Next we are supposed to prepare a button section so again 
new widget which shows the button container*/

Widget btSl = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(Icons.call, 'CALL'),
      _buildButtonColumn(Icons.near_me, 'ROUTE'),
      _buildButtonColumn(Icons.share, 'SHARE'),
    ],
  ),
);

_buildButtonColumn(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.redAccent,
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.red[200],
          ),
        ),
      ),
    ],
  );
}

/*The text widget is here*/

Widget t = Container(
  padding: const EdgeInsets.all(35),
  child: Text(
    "Chhatrapati Sambhajiraje Garden built by Pune Municipal Corporation flaunts the Aquarium of freshwater ornamental fishes, which was set up on 1st Aug 1953. The aquarium at the garden is loved by kids as it serves the educational as well as entertainment purpose for them. "
    "Exercise lovers enjoy the plenty of space and jogging track at the garden. We find the people resting under the cool shades of tall green trees during the daytime. A variety of colourful flower plants soothes eyes and the lovely fragrance tickles nostrils.",
    softWrap: true,
  ),
);
