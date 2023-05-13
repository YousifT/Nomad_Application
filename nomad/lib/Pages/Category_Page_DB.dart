import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Spot_Page.dart';
import 'package:nomad/Pages/User_Pages/app_colors.dart';

var counter = [];

class CategoryPage extends StatefulWidget {
  final categoryType;
  const CategoryPage({super.key, required this.categoryType});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}
class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: FutureBuilder(
        future: Fetchinfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.6,
                              child: Container(
                                
                                child: PageView.builder(
                                  itemCount: snapshot.data[0].length,
                                  itemBuilder: (context, itemCount) => ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Material(
                                      color: Colors.yellow,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SpotPage(
                                                spotObject: snapshot.data[1][itemCount],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          "assets/images/" + snapshot.data[0][itemCount],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (index == 1) {
                        return Column(
                          
                          children: [
                             SizedBox(height: 45,),
                            
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
                                SizedBox(width: 20,),
                                 Text(
                              "${widget.categoryType.toString()} ",
                               style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: AppColors.darkTextColor),
                            ),
                                
                              ],
                            ),
                           SizedBox(height: 5,),
                           Divider(color: Colors.black,thickness: 1,)
                          ],
                        );
                      } else {
                        final cardIndex = index - 2;
                        if (cardIndex < snapshot.data[2].length) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: snapshot.data[2][cardIndex * 2],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: cardIndex * 2 + 1 < snapshot.data[2].length
                                        ? snapshot.data[2][cardIndex * 2 + 1]
                                        : Placeholder(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                    },
                    childCount: snapshot.data[2].length ~/ 2 + 2,
                  ),
                ),
              ],
                     
            
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<dynamic> Fetchinfo() async {
    var listOfDocs = await fetchAllDocs();
    var bannerPaths = [];
    var mappedItems = [];
    var MediumIcons = [];
    for (var item in listOfDocs) {
      if (item['topSpot'] == "True") {
        bannerPaths.add(item['ID'] + "/" + item['image']);
        mappedItems.add(item);
      }
      var mCard = MediumCards(
          name: item['title'],
          location: (calcDistance(item).toString() + "Km"),
          image: "assets/images/" + item['ID'] + "/" + item['image'],
          item: item);
      MediumIcons.add(mCard);
    }
    var listHolder = [bannerPaths, mappedItems, MediumIcons];
    return listHolder;
  }

  Future<dynamic> fetchAllDocs() async {
    CollectionReference database =
        FirebaseFirestore.instance.collection('spots');

    QuerySnapshot snapshot = await database
        .where("category",
            isEqualTo: widget.categoryType
                .toString()
                .substring(0, widget.categoryType.toString().length - 1))
        .get();

    return snapshot.docs;
  }
}

class MediumCards extends StatelessWidget {
  const MediumCards({
    Key? key,
    required this.name,
    required this.location,
    required this.image,
    required this.item,
  }) : super(key: key);

  final String name;
  final String location;
  final String image;
  final item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0), // Set the desired padding for the cards
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Colors.grey, // Set the desired border color for the cards
            width: 1.0, // Set the desired border width for the cards
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpotPage(spotObject: item)),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Set the desired border color for the image
                      width: 1.0, // Set the desired border width for the image
                    ),
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Adjust this ratio based on your image aspect ratio
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0), // Set the desired spacing for the card content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 4.0), // Set the desired spacing between the card title and location
                    Text(
                      location,
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
