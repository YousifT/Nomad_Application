import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/src/rendering/box.dart';

class Venue extends StatefulWidget {
  @override
  _Venue createState() => _Venue();
  const Venue({Key? key}) : super(key: key);
}

class _Venue extends State<Venue> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  final String photoUrl = 'https://googleflutter.com/sample_image.jpg';
  double? _rating;
  IconData? _selectedIcon;
  final List<String> galleryPhotos = [
    'https://googleflutter.com/sample_image.jpg'

    // Add more gallery photos as needed
  ];

  final String description = 'description of my Venue.';
  final String googleMapUrl =
      'https://www.google.com/maps/place/%D9%86%D8%B3%D8%AA%D9%88+%D9%87%D8%A7%D9%8A%D8%A8%D8%B1+%D9%85%D8%A7%D8%B1%D9%83%D8%AA+%D8%AD%D9%8A+%D8%A7%D9%84%D8%B6%D8%A8%D8%A7%D8%A8%E2%80%AD/@26.4340963,50.0474831,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipOZ_n4G6YHSC-WItEt_nLKfw85W-_F39Kgw0gJC!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipOZ_n4G6YHSC-WItEt_nLKfw85W-_F39Kgw0gJC%3Dw114-h86-k-no!7i4000!8i3000!4m7!3m6!1s0x3e49fd163f14902b:0xcad1946dbce33eac!8m2!3d26.4340963!4d50.0474831!10e5!16s%2Fg%2F11r7xv9rwd';
  double rating = 4.5; // Initial rating
  int numReviews = 10; // Initial number of reviews

  TextEditingController WriateReviews = TextEditingController();
  void _launchMapURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];
  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(140),
            ),
            Text(
              'Venue Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Image.network(
              photoUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              'Gallery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: galleryPhotos
                  .map((url) => Image.network(
                        url,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => _launchMapURL(googleMapUrl),
              icon: Icon(Icons.map),
              label: Text('View on Google Maps'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rating: ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '$rating/5.0',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RatingBar.builder(
                initialRating: _rating ?? 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, _) => Icon(
                  _selectedIcon ?? Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                  setState(() {});
                },
              )
            ]),
            SizedBox(height: 8),
            Text(
              '$numReviews reviews',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Reviews',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
