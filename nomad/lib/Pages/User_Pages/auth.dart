import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/main.dart';
import 'package:nomad/Pages/User_Pages/Login%20page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return Myloginpage();
          }
        }),
      ),
    );
  }
}
