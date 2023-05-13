import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/Global_Var.dart' as globals;

import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/Proposal_Form.dart';
import 'package:nomad/Pages/User_Pages/Sginup%20page.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/Pages/User_Pages/app_colors.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:nomad/Pages/Admin_Pages/Reports_page.dart';

import 'HelpCenterPage .dart';

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
      adminCheck = true;
    } else {
      adminCheck = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(30),
        ),
        buildButton(
          context,
          "Profile",
          Icons.person,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          },
        ),
        buildButton(
          context,
          "Submit a Proposal Form",
          Icons.file_upload,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProposalForm(onSubmitted: () {})),
            );
          },
        ),
        buildButton(
          context,
          "Help Center",
          Icons.help,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpCenterPage()),
            );
          },
        ),
        buildButton(
          context,
          "Logout",
          Icons.logout,
          () => signOut(context),
        ),
        Visibility(
          visible: adminC,
          child: buildButton(
            context,
            "Proposals",
            Icons.description,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProposalPage(),
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: adminC,
          child: buildButton(
            context,
            "Reports",
            Icons.report,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportsPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 185, 157, 139),
          onPrimary: AppColors.darkTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero, // Remove the padding
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 50, // Set the height to match the button
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 51, 97, 119),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  globals.global_LoggedIn = false;
  globals.global_isAdmin = false;
}

void navigateAfterSignout(BuildContext context) {
  while (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
  HomePage mainPage = HomePage();
  mainPage.createState();
  Navigator.push(context, MaterialPageRoute(builder: (context) => mainPage));
}
