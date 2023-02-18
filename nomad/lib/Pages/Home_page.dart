import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> imgLinks = [
  "assets/images/img1.jpg",
  "assets/images/img2.jpg",
  "assets/images/img3.jpg"
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.brown,
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: CarouselSlider(
                items: [
                  //Image 1
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(imgLinks[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Image 2
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(imgLinks[1]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Image 3
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(imgLinks[2]),
                        fit: BoxFit.cover,
                      ),
                    ),
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
          ],
        ),
        Text(
          "Hello",
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(title: Text("Title")),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(title: Text("Title")),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(title: Text("Title")),
              ),
            ),
          ],
        )
      ]),
    ));
  }
}
