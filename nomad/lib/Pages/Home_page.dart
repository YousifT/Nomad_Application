import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/UserProfile.dart';
import 'package:nomad/Pages/Category_page.dart';


var HomePageChildren = [
      Sublist("Events", topRatedThree('Events')),
      Sublist("Restaurants", topRatedThree('Restaurants'),
      Sublist("Cafe", topRatedThree('Cafe'))
    ];

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

Future<void> FetchTopThree([var context]) {
CollectionReference database =
      FirebaseFirestore.instance.collection('topSpots');
  QuerySnapshot snapshot = await database.get();
  List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();

  List<dynamic> topEvents = []
  List<dynamic> topRestaurants = []
  List<dynamic> topCafes = []
  HomePageChildren = [];

  for (var spot in result) {
    String value = result['category'];
      if (value == "Event") topEvents.add(spot);
      else if (value == "Restaurant") topRestaurants.add(spot);
      else topCafes.add(spot); 
  }
    HomePageChildren[0] =
    Sublist("Events", topEvents, context);
    HomePageChildren[1] =
    Sublist("Restaurants", topRestaurants, context);
    HomePageChildren[2] =
    Sublist("Cafes", topCafes, context);
}

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
    FetchTopThree(context);

    return Scaffold(
        body: Container(
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
          HomePageChildren[0],
          SizedBox(height: 20),
          HomePageChildren[1],
          SizedBox(height: 20),
          HomePageChildren[2]
        ]),
      ),
    ));
  }
}

Widget Sublist(String title, var items, [var context]) {
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
              title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            Category: title,
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

                        

                        items[0],
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
                        items[1],
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
                        items[2],
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
