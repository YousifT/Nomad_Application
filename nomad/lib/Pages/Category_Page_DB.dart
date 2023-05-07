import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Spot_Page.dart';

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
        appBar: AppBar(
          title: Text(widget.categoryType,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              )),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Fetchinfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Column(
                      children: [
                        //Text(
                        //Category.toString(),
                        //style: TextStyle(
                        //color: Colors.black,
                        //fontSize: 25,
                        //),
                        //)
                      ],
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      sliver: SliverToBoxAdapter(
                        child: AspectRatio(
                          aspectRatio: 1.81,
                          child: PageView.builder(
                            itemCount:
                                snapshot.data[0].length, // Bannerpaths item
                            itemBuilder: (context, itemCount) => ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Material(
                                color: Colors.yellow,
                                child: InkWell(
                                    //toDo "change url based on the clicked image"
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SpotPage(
                                                spotObject: snapshot.data[1][
                                                    itemCount])), // snapshot.data[1][0] first item in the second list of snapshot, i.e: mappedItems
                                        // maybe it should be snapshot.data[0][itemCount]
                                      );
                                    },
                                    child: Image.asset(
                                      "assets/images/" +
                                          snapshot.data[0][itemCount],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )),
                  SliverToBoxAdapter(
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                            "Check out other interseting ${widget.categoryType.toString()} too!",
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          snapshot.data[2].length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: snapshot.data[2][index],
                            /*MediumCards(
                                    name: snapshot.data[2][index]['name'],
                                    image: dummInfo[index]['image'],
                                    location: dummInfo[index]['Location'],
                                    press: () {}, */
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*SliverToBoxAdapter(
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text("category 1",
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            dummInfo.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 4),
                                  child: MediumCards(
                                    name: dummInfo[index]['name'],
                                    image: dummInfo[index]['image'],
                                    location: dummInfo[index]['Location'],
                                    press: () {},
                                  ),
                                )),
                      ),
                    ),
                  ), */
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  Future<dynamic> Fetchinfo() async {
    var listOfDocs = await fetchAllDocs();
    print("finished await, list of docs lenght = ${listOfDocs.length}");
    var bannerPaths = [];
    var mappedItems = [];
    var MediumIcons = [];
    for (var item in listOfDocs) {
      if (item['topSpot'] == "True") {
        bannerPaths.add(item['ID'] + "/" + item['Banner']);
        mappedItems.add(item);
      } else {
        var mCard = MediumCards(
            name: item['title'],
            location: (calcDistance(item).toString() + "Km"),
            image: item['ID'] + "/" + item['image'],
            item: item);
        MediumIcons.add(mCard);
      }
    }
    print("finished for loop");
    var listHolder = [bannerPaths, mappedItems, MediumIcons];
    return listHolder;
  }

  Future<dynamic> fetchAllDocs() async {
    CollectionReference database =
        FirebaseFirestore.instance.collection('spots');

    QuerySnapshot snapshot = await database
        .where("tester", isEqualTo: "a")
        .get(); // ("category", isEqualTo: widget.categoryType).get();

    return snapshot.docs;
  }
}

class MediumCards extends StatelessWidget {
  const MediumCards({
    super.key,
    required this.name,
    required this.location,
    required this.image,
    required this.item,
  });
  final String name, location, image;
  final item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => SpotPage(spotObject: item))),
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(location,
                style: TextStyle(color: Color.fromARGB(255, 185, 141, 125))),
          ],
        ),
      ),
    );
  }
}