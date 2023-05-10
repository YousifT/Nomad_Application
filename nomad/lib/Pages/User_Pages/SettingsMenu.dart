import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/HelpCenterPage%20.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/main.dart';

Future SignOut(var context) async {
  await FirebaseAuth.instance.signOut();
  globals.global_LoggedIn = false;
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

class SettingsMenu extends StatelessWidget {
  @override
  SettingsMenu createState() => SettingsMenu();
  const SettingsMenu({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(30),
        ),
        SizedBox(
            height: 75, //height of button
            width: 350, //width of button
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              },
              child: Text(" Profile"),
            )),
        SizedBox(
            height: 75, //height of button
            width: 350, //width of button
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Notifications"),
            )),
        SizedBox(
            height: 75, //height of button
            width: 350, //width of button
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Settings"),
            )),
        SizedBox(
            height: 75, //height of button
            width: 350, //width of button
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpCenterPage()));
              },
              child: Text("Help Center"),
            )),
        SizedBox(
          height: 75, //height of button
          width: 350, //width of button
          child: ElevatedButton(
            onPressed: () => SignOut(context),
            child: Text("Logout"),
          ),
        ),
      ],
    );
  }
}
