import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomad/Global_Var.dart' as globals;
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
  const UserProfile({Key? key}) : super(key: key);
}

Future SignOut(var context) async {
  await FirebaseAuth.instance.signOut();
  globals.global_LoggedIn = false;
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isHidden = false;

  @override
  void initState() {
    super.initState();
    // Retrieve email and password values from Cloud Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          fnameController.text = documentSnapshot.get('first_name');
          lnameController.text = documentSnapshot.get('last_name');
          emailController.text = documentSnapshot.get('email');
          passwordController.text = documentSnapshot.get('password');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              fnameController.text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fnameController,
              decoration: InputDecoration(
                hintText: 'Enter your fname',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              lnameController.text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your lname',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              emailController.text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: _isHidden,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                  child: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Update email and password values in Cloud Firestore
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'email': emailController.text,
                      'password': passwordController.text,
                    });
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
