import 'package:flutter/material.dart';
import 'package:nomad/Pages/Explore_page.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Login%20page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nomad',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var pages = [
  GuidePage(),
  MyHomePage(),
  ProfilePage(),
  Mysginuppage(),
  Myloginpage()
];

var testerPages = [
  GuidePage(),
  MyHomePage(),
  Mysginuppage(),
];

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;
  bool LoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: testerPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Guide"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}
