import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Review_card.dart';
import 'package:nomad/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/src/rendering/box.dart';

import 'User_Pages/app_colors.dart';

Color myColor = Color(0xff00bfa5);
double? _rating;
IconData? _selectedIcon;
TextEditingController reviewFormController = TextEditingController();
String totalRatings = "0.0";

class Review {
  final String name;
  final String comment;
  double rating;
  Review(this.name, this.comment, this.rating);
}

final List<Review> reviews = [
  Review('John Doe', 'Great product, highly recommended!', 4.5),
  Review('Alice Smith', 'Very satisfied with my purchase.', 5),
  Review('Bob Johnson', 'Excellent customer service.', 3.5),
];

Future<void> _launchMapURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SpotPage extends StatefulWidget {
  final spotObject;
  SpotPage({super.key, required this.spotObject});

  @override
  State<SpotPage> createState() => _SpotPageState();
}

class _SpotPageState extends State<SpotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: loadReviews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
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
                              image: AssetImage(
                                  "assets/images/${widget.spotObject['ID'].toString()}/${widget.spotObject['image']}"),
                              fit: BoxFit.fill,
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
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 8)
                            ]),
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
                                  "${widget.spotObject['title']}",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.darkTextColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),

                            ///Container for data
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 40, left: 15, bottom: 5),
                              padding: EdgeInsets.only(left: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        totalRatings,
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
                                        "${calcDistance(widget.spotObject).toString()} KM",
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
                                      // google map icon
                                      InkWell(
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                shape: BoxShape.rectangle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black45,
                                                      blurRadius: 6)
                                                ]),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.asset(
                                                      "assets/images/Google_Maps_icon.png",
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Location",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .darkTextColor),
                                                )
                                              ],
                                            )),
                                        onTap: () => _launchMapURL(
                                            widget.spotObject['location']),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
                          widget.spotObject['description'],
                          style: GoogleFonts.poppins(
                              color: AppColors.veryLightTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "Reviews",
                          style: GoogleFonts.poppins(
                              color: AppColors.lightGreenColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //reviews holder

                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final review = snapshot.data[index];
                            return Card(
                              color: Color.fromARGB(255, 231, 227, 227),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data[index]['user']),
                                    RatingBar.builder(
                                      initialRating: snapshot.data[index]
                                          ['Stars'],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: AppColors.lightGreenColor,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          review.rating = rating;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(snapshot.data[index]['Review']),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            openAlertBox();
          },
          backgroundColor: AppColors.lightGreenColor,
          label: Text("Add Review"),
          icon: Icon(Icons.add),
        ));
  }

  Future<dynamic> loadReviews() async {
    CollectionReference database =
        FirebaseFirestore.instance.collection('reviews');

    var empty = [
      Review('Empty', 'No Reviews for this spot exist', 0),
    ];

    QuerySnapshot snapshot = await database
        .where("Parent_Spot", isEqualTo: widget.spotObject['ID'])
        .get();

    num sumOfStars = 0;
    for (var item in snapshot.docs) {
      sumOfStars = sumOfStars + item['Stars'];
    }
    if (sumOfStars == 0) {
      totalRatings = "0.0";
    } else {
      double res = sumOfStars / snapshot.docs.length;
      totalRatings = res.toString();
    }

    return snapshot.docs;
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Rate",
                        style: TextStyle(fontSize: 24.0),
                      ),

                      //star row
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        RatingBar.builder(
                          initialRating: _rating ?? 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 28,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          itemBuilder: (context, _) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Colors.amber[700],
                          ),
                          onRatingUpdate: (rating) {
                            _rating = rating;
                            setState(() {});
                          },
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: reviewFormController,
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Submit Review",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      submitReview();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> submitReview() {
    CollectionReference database =
        FirebaseFirestore.instance.collection('reviews');
    var docID = database.doc();
    return database.doc(docID.id).set({
      'Parent_Spot': widget.spotObject['ID'],
      'Review': reviewFormController.text,
      'Stars': _rating,
      'user': globals.global_FullName,
      'Review_ID': docID.id,
    }).then((value) => print("added to DB"));
  }
}
