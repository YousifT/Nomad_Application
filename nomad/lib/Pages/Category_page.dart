import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';

List<Map<String, dynamic>> dummInfo = [
  {
    "name": "Starbucks",
    "image": "assets/images/img1.jpg",
    "Location": "Olaya, B3",
  },
  {
    "name": "Coffeeshop",
    "image": "assets/images/img2.jpg",
    "Location": "somewhere",
  },
  {
    "name": "Coffeeshop",
    "image": "assets/images/img3.jpg",
    "Location": "somewhere",
  },
  {
    "name": "Coffeeshop2",
    "image": "assets/images/img1.jpg",
    "Location": "somewhere2",
  }
];

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, this.Category});
  final String? Category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Category.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            )),
        centerTitle: true,
      ),
      body: CustomScrollView(
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
                    itemCount: imgLinks.length,
                    itemBuilder: (context, itemCount) => ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Material(
                        color: Colors.yellow,
                        child: InkWell(
                            //toDo "change url based on the clicked image"
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: Image.asset(
                              imgLinks[itemCount],
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
                child: Text("Hotspots",
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
                          padding: const EdgeInsets.only(right: 8.0, left: 4),
                          child: MediumCards(
                            name: dummInfo[index]['name'],
                            image: dummInfo[index]['image'],
                            location: dummInfo[index]['Location'],
                            press: () {},
                          ),
                        )),
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                          padding: const EdgeInsets.only(right: 8.0, left: 4),
                          child: MediumCards(
                            name: dummInfo[index]['name'],
                            image: dummInfo[index]['image'],
                            location: dummInfo[index]['Location'],
                            press: () {},
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MediumCards extends StatelessWidget {
  const MediumCards({
    super.key,
    required this.name,
    required this.location,
    required this.image,
    required this.press,
  });
  final String name, location, image;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: press,
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
