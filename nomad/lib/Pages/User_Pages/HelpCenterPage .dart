import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPage createState() => _HelpCenterPage();
}

class _HelpCenterPage extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nomad is a professional travel application showcasing unique places, allowing users to explore and engage. It offers a key feature of displaying distance to desired locations for convenient navigation. Travelers and locals can discover hidden gems and popular attractions in Khobar, benefiting from real-time feedback and recommendations. Nomad enhances travel experiences, fosters community engagement, and provides a comprehensive guide to remarkable places in Khobar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text("Proposal Forms",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(
              "Know of an amazing spot that isn't covered in our application? We'd be glad to add it!\nJust submit us a proposal, and we'll take a look at it!\nYou can submit a proposal by going through Profile page -> \"Submit a Proposal\" and filling up the form.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: support@nomadapp.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Phone: +966-509-505-166',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
