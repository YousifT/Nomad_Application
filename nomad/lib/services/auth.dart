import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nomad/main.dart';
import 'package:nomad/services/database.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    return await auth.currentUser!;
  }

  Future<void> createUserWithEmailAndPassword(String email, String fName,
      String lName, String password, DateTime createAt) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    Map<String, dynamic> userInfoMap = {
      'email': email,
      'firstNamme': fName,
      'lastName': lName,
      'password': password,
      'createAt': createAt,
    };

    if (userCredential != null) {
      DatabaseService().addUserInfoToDB(auth.currentUser!.uid, userInfoMap);
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
