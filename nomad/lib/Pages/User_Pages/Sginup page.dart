import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/User_Pages/Login%20page.dart';
import 'package:nomad/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var _main = new HomePage();

class Mysginuppage extends StatelessWidget {
  const Mysginuppage({Key? key}) : super(key: key);

  static const String _title = 'Nomad';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Fname = TextEditingController();
  final Lname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final adminC = TextEditingController().text;
  Future<void> signUp(String fname, String lname, String email, String password,
      String cpassword) async {
    // Check if passwords match
    if (password != cpassword) {
      throw Exception("Passwords do not match");
    }

    try {
      // Create a new user with the provided email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Get the user's unique ID
      String uid = userCredential.user!.uid;

      // Create a reference to the user's document in Cloud Firestore
      DocumentReference usersRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Store user data in Cloud Firestore
      await usersRef.set({
        'Time': DateTime.now(),
        'first_name': fname,
        'last_name': lname,
        'email': email,
        'password': password,
        'uid': uid,
        'Admin': "False",
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Myloginpage()));
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      // Handle sign-up errors, such as email already in use, etc.
      throw Exception(e.message);
    } catch (e) {
      print("Error: $e");
      // Handle any other errors that might occur
      throw Exception("An error occurred while signing up");
    }
  }

  @override
  void dispose() {
    Fname.dispose();
    Lname.dispose();
    email.dispose();
    password.dispose();
    cpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Fname = TextEditingController();
    final Lname = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final cpassword = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Nomad',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: Fname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: Lname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: false,
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: cpassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' rewrite Password',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GestureDetector(
                onTap: () {
                  signUp(Fname.text, Lname.text, email.text, password.text,
                      cpassword.text);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Sgin Up'),
                    onPressed: () {
                      signUp(Fname.text, Lname.text, email.text, password.text,
                          cpassword.text);
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  // Login button press
                  // Switches screens to MyloginPage()
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Myloginpage()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
