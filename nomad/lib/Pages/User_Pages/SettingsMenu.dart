import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/User_Pages/HelpCenterPage%20.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/Proposal_Form.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:nomad/Pages/Admin_Pages/Reports_page.dart';

Future<void> signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  globals.global_LoggedIn = false;
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

bool adminC = false;

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (globals.global_isAdmin == true) {
      adminC = true;
    } else {
      adminC = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(30),
        ),
        SizedBox(
          height: 75,
          width: 350,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
            child: Text("Profile"),
          ),
        ),
        SizedBox(
          height: 75,
          width: 350,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProposalForm(onSubmitted: () {})),
              );
            },
            child: Text("Submit a Proposal Form"),
          ),
        ),
        SizedBox(
          height: 75,
          width: 350,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpCenterPage()),
              );
            },
            child: Text("Help Center"),
          ),
        ),
        SizedBox(
          height: 75,
          width: 350,
          child: ElevatedButton(
            onPressed: () => signOut(context),
            child: Text("Logout"),
          ),
        ),
        Visibility(
          visible: adminC,
          child: SizedBox(
            height: 75,
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsPage()),
                );
              },
              child: Text("Proposals"),
            ),
          ),
        ),
        Visibility(
          visible: adminC,
          child: SizedBox(
            height: 75,
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsPage()),
                );
              },
              child: Text("Reports"),
            ),
          ),
        ),
      ],
    );
  }
}
