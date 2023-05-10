import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Pages/Explore_page.dart';
import 'package:nomad/Pages/Guide_Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Location.dart';
import 'package:nomad/Pages/User_Pages/Login%20page.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:nomad/Pages/Admin_Pages/Reports_page.dart';
import 'package:nomad/Pages/User_Pages/Sginup%20page.dart';
import 'package:nomad/Pages/User_Pages/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:nomad/Global_Var.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocationPermission _UserLocation = new LocationPermission();
  await _UserLocation.getLocation();
  await FetchTopThree();
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
      routes: {
        'signupscreen': (context) => const Mysginuppage(),
        'loginscreen': (context) => const Myloginpage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // When a user logs in - Update the LoggedIn variable, and reinsitate the BottomNavigationBar with a different profile page
  // Should work the same way with Sign out button if you pass "false" (not added yet).

  // Current bug: BottomNavBar icon highlight isnt updated with this route update.
  updateBottomNavBar(bool value, context) {
    globals.global_LoggedIn = value;
    createState();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    if (globals.global_LoggedIn == false) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: IndexedStack(
          index: selectedPage,
          children: globals.global_GuestUser_Pages,
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ]),
      );
    } else {
      if (globals.global_isAdmin == false) {
        return Scaffold(
          body: IndexedStack(
            index: selectedPage,
            children: globals.global_LoggedIn_Pages,
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
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile")
              ]),
        );
      }
      // Logged in User is an admin
      else {
        return Scaffold(
          body: IndexedStack(
            index: selectedPage,
            children: globals.global_adminUser_Pages,
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
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.admin_panel_settings), label: "Admin")
              ]),
        );
      }
    }
  }
}

Future<void> FetchTopThree([var context]) async {
  var results = [];
  var database = FirebaseFirestore.instance;
  await database.collection('spots').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        results.add(docSnapshot);
      }
    },
    onError: (e) => print("Error completing: $e"),
  ).then((value) => print("Completed Fetching"));

  List<dynamic> topEvents = [];
  List<dynamic> topRestaurants = [];
  List<dynamic> topCafes = [];

  for (int i = 0; i < results.length; i++) {
    if (results[i]['topSpot'] == "True") {
      String value = results[i]["category"];
      if (value == "Event")
        topEvents.add(results[i]);
      else if (value == "Restaurant")
        topRestaurants.add(results[i]);
      else if (value == "Cafe") topCafes.add(results[i]);
    }
  }
  globals.HomePageChildren = [];
  sublistItem e_item = sublistItem("Events", topEvents);
  globals.HomePageChildren.add(e_item);
  sublistItem r_item = sublistItem("Restaurants", topRestaurants);
  globals.HomePageChildren.add(r_item);
  sublistItem c_item = sublistItem("Cafes", topCafes);
  globals.HomePageChildren.add(c_item);
}
