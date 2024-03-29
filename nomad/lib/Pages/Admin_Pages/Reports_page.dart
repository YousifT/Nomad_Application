import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isBanned = false;

  Future<void> _banUser(String reviewId) async {
    await _firestore
        .collection('banned_users')
        .doc(globals.global_UserEmail)
        .set({'email': globals.global_UserEmail});
    await _firestore.collection('reviews').doc(reviewId).delete();
    setState(() {
      _isBanned = true;
    });
  }

  Future<void> _deleteReport(String docId) async {
    await _firestore.collection('reports').doc(docId).delete();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Ban Banner'),
        backgroundColor: Color.fromARGB(255, 185, 157, 139),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('reports').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot report = snapshot.data!.docs[index];

                    // Wrap Container with InkWell to make it clickable
                    return InkWell(
                      onTap: () async {
                        // Show a confirmation dialog to delete the report
                        bool? shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('ban user'),
                              content: Text(
                                  'Are you sure you want to ban this user?'),
                              actions: [
                                TextButton(
                                  onPressed: () => {
                                    _banUser(report.get(
                                        'Review_ID')), // Pass the reviewId from the report document
                                    Navigator.of(context).pop(true)
                                  },
                                  child: Text('Ban'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    _deleteReport(report.id),
                                    Navigator.of(context).pop(true)
                                  },
                                  child: Text('Reject report'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );

                        // If the user confirmed, delete the report
                        if (shouldDelete == true) {
                          _deleteReport(report.id);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(report.get('Reported_user')),
                            ),
                            Text(
                              'Review',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(report.get('Review')),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
