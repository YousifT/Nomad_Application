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
        resizeToAvoidBottomInset: false,
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
  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signUp(String fname, String lname, String email, String password,
      String cpassword) async {
    // Check if passwords match
    if (password != cpassword) {
      showSnackBar("An error occurred while logging in");
      return;
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
      // Handle sign-up errors, such as email already in use, etc.
      showSnackBar("A FirebaseAuthException occurred while signing up");
    } catch (e) {
      // Handle any other errors that might occur
      showSnackBar("An error occurred while signing up");
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
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Column(
                children: const [
                  Image(
                      image: AssetImage("assets/images/nomad.png"),
                      height: 125,
                      width: 125),
                  Padding(
                    padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                    child: Text(
                      'Nomad',
                      style: TextStyle(
                          color: Color.fromARGB(255, 170, 127, 41),
                          fontWeight: FontWeight.w500,
                          fontSize: 28),
                    ),
                  ),
                ],
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(18, 0, 10, 10),
              child: const Text(
                'Sign up',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 47, 66, 75),
                    fontWeight: FontWeight.w500),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: TextField(
              controller: Fname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
                labelStyle: TextStyle(color: Color.fromARGB(255, 66, 92, 105)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              controller: Lname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Color.fromARGB(255, 66, 92, 105)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              obscureText: false,
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(color: Color.fromARGB(255, 66, 92, 105)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(color: Color.fromARGB(255, 66, 92, 105)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
            child: TextField(
              obscureText: true,
              controller: cpassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rewrite Password',
                labelStyle: TextStyle(color: Color.fromARGB(255, 66, 92, 105)),
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
                height: 35,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 90, 133, 155)),
                  child: const Text('Sign Up',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  onPressed: () {
                    signUp(Fname.text, Lname.text, email.text, password.text,
                        cpassword.text);
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 184, 138, 44)),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 184, 138, 44)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Myloginpage()));
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
