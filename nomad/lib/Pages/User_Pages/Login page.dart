import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Global_Var.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/SettingsMenu.dart';
import 'package:nomad/Pages/User_Pages/Sginup%20page.dart';
import 'package:nomad/Pages/User_Pages/UserProfile.dart';
import 'package:nomad/Pages/User_Pages/auth.dart';
import 'package:nomad/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Myloginpage extends StatelessWidget {
  const Myloginpage({Key? key}) : super(key: key);

  static const String _title = 'Nomad';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _firstLogin = true;

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      global_LoggedIn = true;
      global_UserEmail = email;
      CollectionReference database =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot snapshot =
          await database.where("email", isEqualTo: email).get();
      if (snapshot.docs[0]['Admin'] == "True") {
        global_isAdmin = true;
      }
      global_FullName =
          "${snapshot.docs[0]['first_name']} ${snapshot.docs[0]['last_name']}";

      CollectionReference banQuery =
          FirebaseFirestore.instance.collection('banned_users');
      QuerySnapshot banSnapshot =
          await banQuery.where("email", isEqualTo: email).get();
      if (banSnapshot.docs.isNotEmpty) {
        global_isBanned = true;
      }

      goToHomePage();
    } on FirebaseAuthException catch (e) {
      showSnackBar("An error occurred while Sgin in");
    } catch (e) {
      showSnackBar("An error occurred while Sgin Up");
    }
  }

  void goToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void opensignupscreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Mysginuppage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          color: Color.fromARGB(
              255, 236, 213, 198), // Desert-themed background color
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Nomad',
                    style: TextStyle(
                        color: Color.fromARGB(255, 207, 124, 29),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 207, 124, 29)),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Color.fromARGB(255, 150, 87, 51)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  login(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    )),
              ),
              Row(
                children: <Widget>[
                  const Text('Dont have account?'),
                  GestureDetector(
                    onTap: opensignupscreen,
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 150, 87, 51)),
                    ),
                    //signup button press
                    // switches the screen to Mysignuppage()
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
