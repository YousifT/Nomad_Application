import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'User_Pages/app_colors.dart';

class SpotPage extends StatefulWidget {
  final spotObject;
  const SpotPage({super.key, required this.spotObject});

  @override
  State<SpotPage> createState() => _SpotPageState();
}

class _SpotPageState extends State<SpotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white30,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image container
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img1.jpg"),
                    fit: BoxFit.cover,
                  ),
                )),
            //location card
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)]),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Title",
                        style: GoogleFonts.poppins(
                            color: AppColors.darkTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),

                  ///Container for data
                  Container(
                    margin:
                        const EdgeInsets.only(right: 40, left: 15, bottom: 5),
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.lightGreenColor,
                              size: 22,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "4.0",
                              style: GoogleFonts.poppins(
                                color: AppColors.darkTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.lightTextColor,
                              size: 22,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "125 Km",
                              style: GoogleFonts.poppins(
                                color: AppColors.veryLightTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Favorate icon
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 8)
                                  ]),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///Back button
            Row(
              children: [],
            ),

            ///Spacing
            SizedBox(
              height: 24,
            ),

            ///About text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "About",
                style: GoogleFonts.poppins(
                    color: AppColors.lightGreenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            ///About detail text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco",
                style: GoogleFonts.poppins(
                    color: AppColors.veryLightTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add Location here!
          },
          backgroundColor: Colors.black26,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/Google_Maps_icon.png",
                width: 54,
                height: 54,
              ),
            ),
          )),
    );
  }

  Future<dynamic> loadReviews() async {
    CollectionReference database =
        FirebaseFirestore.instance.collection('reviews');

    QuerySnapshot snapshot = await database
        .where("Parent_Spot", isEqualTo: "aaa") //widget.spotObject['id']
        .get();
    print(snapshot.docs.length);

    return snapshot.docs;
  }
}
