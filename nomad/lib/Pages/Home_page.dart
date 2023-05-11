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
import 'package:nomad/Pages/Category_page.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Global_Var.dart' as globals;

import 'Category_Page_DB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var ImageOne = globals.HomePageChildren[1].items[0];
var ImageTwo = globals.HomePageChildren[1].items[1];
var ImageThree = globals.HomePageChildren[1].items[2];

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
                              image: DecorationImage(
                                image: AssetImage(imgLinks[0]),
                                fit: BoxFit.fill,
                              )),
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
                            image: DecorationImage(
                              image: AssetImage(imgLinks[1]),
                              fit: BoxFit.fill,
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
                            image: DecorationImage(
                              image: AssetImage(imgLinks[2]),
                              fit: BoxFit.fill,
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

                    // Slider Container properties
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
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
          child: InkWell(
            onTap: () {
              Navigator.push(
                subListitem.context,
                MaterialPageRoute(
                  builder: (context) => SpotPage(
                    spotObject: subListitem.items,
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
        Divider(
          thickness: 3,
          color: Colors.black38,
        ),

        // Per Elements part start

        Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 8),
                color: Colors.white30,
                child: InkWell(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            image: AssetImage(
                                "assets/images/${subListitem.items[0]['ID']}/${subListitem.items[0]['image']}"),
                            width: 130,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          subListitem.items[0]['title'],
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "${calcDistance(subListitem.items[0])}KM",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        subListitem.context,
                        MaterialPageRoute(
                            builder: (context) => SpotPage(
                                  spotObject: subListitem.items[0],
                                )),
                      );
                    })),
            Divider(thickness: 2),
            Container(
                padding: EdgeInsets.only(top: 8),
                color: Colors.white30,
                child: InkWell(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image(
                          image: AssetImage(
                              "assets/images/${subListitem.items[1]['ID']}/${subListitem.items[1]['image']}"),
                          width: 130,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        subListitem.items[1]['title'],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "${calcDistance(subListitem.items[1])}KM",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      subListitem.context,
                      MaterialPageRoute(
                          builder: (context) => SpotPage(
                                spotObject: subListitem.items[1],
                              )),
                    );
                  },
                )),
            Divider(thickness: 2),
            Container(
                padding: EdgeInsets.only(top: 8),
                color: Colors.white30,
                child: InkWell(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Image(
                            image: AssetImage(
                                "assets/images/${subListitem.items[2]['ID']}/${subListitem.items[2]['image']}"),
                            width: 130,
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          subListitem.items[2]['title'],
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "${calcDistance(subListitem.items[2])}KM",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        subListitem.context,
                        MaterialPageRoute(
                            builder: (context) => SpotPage(
                                  spotObject: subListitem.items[2],
                                )),
                      );
                    })),
            Divider(thickness: 2),
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
