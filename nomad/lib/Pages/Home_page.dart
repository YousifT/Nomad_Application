import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/UserProfile.dart';
import 'package:nomad/Pages/Category_page.dart';

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
    var HomePageChildren = [
      Sublist("Events", topRatedThree('Events'), context),
      Sublist("Restaurants", topRatedThree('Restaurants'), context),
      Sublist("Cafe", topRatedThree('Cafe'), context)
    ];
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
          HomePageChildren[1],
          HomePageChildren[2]
        ]),
      ),
    ));
  }
}

Widget Sublist(String title, var items, [var context]) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8, 10, 4, 3),
    //color: Colors.green,
    child: SizedBox(
      height: 400,
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
              icon: Icon(Icons.arrow_forward),
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
        ),Divider(thickness: 3,color: Colors.black38,),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
              color: Colors.white30,
              child : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image(image: AssetImage("assets/images/img1.jpg"), width: 130 , height: 80, fit: BoxFit.cover,),
                    
                  ),
                  const SizedBox(width:50),
                   Text(
                    "Element 1",
                    style: TextStyle(fontSize: 18 , color: Colors.black) ,
                  ),
                ],
              )
            ),Divider(thickness: 2),
             Container(
              padding: EdgeInsets.only(top: 8),
              color: Colors.white30,
              child : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image(image: AssetImage("assets/images/img1.jpg"), width: 130 , height: 80, fit: BoxFit.cover,),
                    
                  ),
                  const SizedBox(width:50),
                   Text(
                    "Element 2",
                    style: TextStyle(fontSize: 18 , color: Colors.black) ,
                  ),
                ],
              )
            ),Divider(thickness: 2),
             Container(
              padding: EdgeInsets.only(top: 8),
              color: Colors.white30,
              child : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image(image: AssetImage("assets/images/img1.jpg"), width: 130 , height: 80, fit: BoxFit.cover,),
                    
                  ),
                const SizedBox(width:50),
                   Text(
                    "Element 3",
                    style: TextStyle(fontSize: 18 , color: Colors.black) ,
                  ),
                ],
              )
            ),Divider(thickness: 2),
          ],
        )
      ]),
    ),
  );
}
