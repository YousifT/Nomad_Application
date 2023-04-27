import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/UserProfile.dart';
import 'package:nomad/Pages/Category_page.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Global_Var.dart' as globals;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Image links for the CarouselSlider.
// Should be dynamically pulled from DB in the future.

List<String> imgLinks = [
  "assets/images/img1.jpg",
  "assets/images/img2.jpg",
  "assets/images/img3.jpg"
];

// DB TopThree
// Right now there is no "topSpots" collection in the DB so you need to create that
// Or alt: add a grading criteria to "spots"

// TopRatedThree should be replaced by a method that connects to the Database and gets the relevant data
topRatedThree(String table) {
  if (table == "Events")
    return ["Event_1", "Event_2", "Event_3"];
  else if (table == "Restaurants")
    return ["Restaurant_1", "Restaurant_2", "Restaurant_3"];
  else
    return ["Cafe_1", "Cafe_2", "Cafe_3"];
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print("LEN: " + globals.HomePageChildren.length.toString());

    return Container(
      //maxFinite Height and Width to cover the whole screen
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
                      //Image 1
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(imgLinks[0]),
                                fit: BoxFit.cover,
                              )),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserProfile())),
                      ),

                      // Image 2
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(imgLinks[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mysginuppage())),
                      ),

                      // Image 3
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(imgLinks[2]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GuidePage())),
                      ),
                    ],

                    //Slider Container properties
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
          Sublist(globals.HomePageChildren[0]),
          SizedBox(height: 20),
          Sublist(globals.HomePageChildren[1]),
          SizedBox(height: 20),
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
      height: 270,
      width: double.maxFinite,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subListitem.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(
                  subListitem.context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            Category: subListitem.title,
                          )),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            width: double.maxFinite,

            // Each card starts here, you can change the whole styling of it
            // and add more information taken from the DB as explained in line 212.
            // We still dont have any images added to the DB nor the to the UI design
            // so thats one point that needs fixing.
            child: Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  children: [
                    Icon(Icons.food_bank),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        // Item 0 is the first spot entry, should be able to access
                        // item[0]['Title'] values and similar information

                        // Update all other items the same way within the sublist widget

                        // if we add longtitude and latitude of each spot, in the DB, we can also add
                        // more information to the homepage sublit, such as distance.
                        // Just calculate the difference
                        // between global_Var longtitude and latitude and spot long/lat

                        subListitem.items[0]['title'],
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  children: [
                    Icon(Icons.food_bank),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        subListitem.items[1]['title'],
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  children: [
                    Icon(Icons.food_bank),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        subListitem.items[2]['title'],
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    ),
  );
}
