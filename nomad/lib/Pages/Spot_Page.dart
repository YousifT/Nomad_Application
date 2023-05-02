import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
      appBar: AppBar(
        title: Text(
          widget.spotObject['title'],
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.spotObject['title']),
          Text(widget.spotObject['category']),
          Text(widget.spotObject['location']),
          FutureBuilder(
            future: loadReviews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("waiting");
              } else {
                try {
                  return Text(snapshot.data[0]['Parent_Spot']);
                } catch (e) {
                  return Text("No data found");
                }
              }
            },
          )
        ],
      ),
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
