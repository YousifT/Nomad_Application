import 'package:flutter/material.dart';
import 'package:nomad/Pages/Explore_page.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Location.dart';
import 'package:nomad/Pages/Login%20page.dart';
import 'package:nomad/Pages/Proposals_page.dart';
import 'package:nomad/Pages/Reports_page.dart';
import 'package:nomad/Pages/Sginup%20page.dart';
import 'package:nomad/Pages/profile_page.dart';
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
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    if (globals.global_LoggedIn == false) {
      return Scaffold(
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
              BottomNavigationBarItem(icon: Icon(Icons.map), label: "Guide"),
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
                BottomNavigationBarItem(icon: Icon(Icons.map), label: "Guide"),
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
                BottomNavigationBarItem(icon: Icon(Icons.map), label: "Guide"),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.report), label: "Reports"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.report_off_rounded), label: "Proposals")
              ]),
        );
      }
    }
  }
}
