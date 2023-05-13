import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomad/Pages/Guide_Pages/Guide_page.dart';
import 'package:nomad/Pages/Spot_Page.dart';
import 'package:nomad/Pages/User_Pages/Sginup%20page.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/Pages/Extra_Pages/Category_page.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Global_Var.dart' as globals;

import 'Category_Page_DB.dart';
import 'User_Pages/app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var ImageOne = globals.HomePageChildren[0].items[0];
var ImageTwo = globals.HomePageChildren[1].items[2];
var ImageThree = globals.HomePageChildren[2].items[1];

List<String> imgLinks = [
  "assets/images/" + ImageOne['ID'] + "/" + ImageOne['image'],
  "assets/images/" + ImageTwo['ID'] + "/" + ImageTwo['image'],
  "assets/images/" + ImageThree['ID'] + "/" + ImageThree['image'],
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    for (sublistItem obj in globals.HomePageChildren) {
      obj.context = context;
    }

    return Container(
      // maxFinite Height and Width to cover the whole screen
      height: double.maxFinite,
      width: double.maxFinite,

      // Scrollable widget wrapping to hold the Column so it becomes scrollable
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CarouselSlider(
                    items: [
                      // Image 1
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 149, 152, 155),
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              imgLinks[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SpotPage(spotObject: ImageOne))),
                      ),

                      // Image 2
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 149, 152, 155),
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              imgLinks[1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SpotPage(spotObject: ImageTwo))),
                      ),

                      // Image 3
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 149, 152, 155),
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              imgLinks[2],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SpotPage(spotObject: ImageThree))),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 190.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1, // Set viewportFraction to 1.0
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Sublist(globals.HomePageChildren[0]),
          SizedBox(height: 10),
          Sublist(globals.HomePageChildren[1]),
          SizedBox(height: 10),
          Sublist(globals.HomePageChildren[2])
        ]),
      ),
    );
  }
}

class sublistItem {
  late String title;
  late var items;
  late var context;
  sublistItem(String t, var item, [var c]) {
    title = t;
    items = item;
    context = c;
  }
}

Widget Sublist(sublistItem subListitem) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8, 10, 4, 3),
    child: SizedBox(
      height: 380,
      width: double.maxFinite,
      child: Column(children: [
        Expanded(
          child: Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  subListitem.context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      categoryType: subListitem.title,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subListitem.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        subListitem.context,
                        MaterialPageRoute(
                          builder: (context) => SpotPage(
                            spotObject: subListitem.items,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        Divider(
          thickness: 3,
          color: Colors.black38,
        ),

        // Per Elements part start

        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Change the color to a desired grey shade
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.5),
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                border:
                    Border.all(color: Colors.black26), // Add rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 167, 167, 167).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ], // Add slight shadow
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    subListitem.context,
                    MaterialPageRoute(
                      builder: (context) => SpotPage(
                        spotObject: subListitem.items[0],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            image: AssetImage(
                              "assets/images/${subListitem.items[0]['ID']}/${subListitem.items[0]['image']}",
                            ),
                            width: 200,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                subListitem.items[0]['title'],
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 65,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 183, 214, 230),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${calcDistance(subListitem.items[0])} KM",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),

            // item 2
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Change the color to a desired grey shade
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.5),
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                border:
                    Border.all(color: Colors.black26), // Add rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 167, 167, 167).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ], // Add slight shadow
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    subListitem.context,
                    MaterialPageRoute(
                      builder: (context) => SpotPage(
                        spotObject: subListitem.items[1],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            image: AssetImage(
                              "assets/images/${subListitem.items[1]['ID']}/${subListitem.items[1]['image']}",
                            ),
                            width: 200,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                subListitem.items[1]['title'],
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 65,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 183, 214, 230),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${calcDistance(subListitem.items[1])} KM",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),

            // item 3
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Change the color to a desired grey shade
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.5),
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                border:
                    Border.all(color: Colors.black26), // Add rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 167, 167, 167).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ], // Add slight shadow
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    subListitem.context,
                    MaterialPageRoute(
                      builder: (context) => SpotPage(
                        spotObject: subListitem.items[2],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            image: AssetImage(
                              "assets/images/${subListitem.items[2]['ID']}/${subListitem.items[2]['image']}",
                            ),
                            width: 200,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                subListitem.items[2]['title'],
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 65,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 183, 214, 230),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${calcDistance(subListitem.items[2])} KM",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ]),
    ),
  );
}

double calcDistance(var item) {
  var Lat;
  var Long;

  try {
    Lat = item['latitude'];
  } catch (e) {
    Lat = 26.34615;
  }

  try {
    Long = item['longitude'];
  } catch (e) {
    Long = 50.145467;
  }

  Distance distance = new Distance();
  if (globals.global_Latitude != null && globals.global_Longitude != null) {
    return distance.as(
        LengthUnit.Kilometer,
        LatLng(globals.global_Latitude!, globals.global_Longitude!),
        LatLng(Lat, Long));
  } else {
    return 0.0;
  }
}
