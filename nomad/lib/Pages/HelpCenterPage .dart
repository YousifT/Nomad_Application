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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          GuideTile(
            title: 'Help Centerinfo',
            description: 'our info..........',
            onTap: () {
              content:
              Text(
                  'you should  have an account then go to 1-  then 2- then 3-');
            },
          ),
          GuideTile(
            title: 'Account Management',
            description:
                'you should  have an account then go to 1-  then 2- then 3-',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class GuideTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  GuideTile(
      {required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
