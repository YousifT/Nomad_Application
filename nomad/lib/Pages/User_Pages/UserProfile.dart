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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isHidden = true;
  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
        });
      }
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Update user data in Firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'first_name': fnameController.text,
          'last_name': lnameController.text,
          'email': emailController.text,
        }).then((_) async {
          // Update user email and password in FirebaseAuth
          if (currentUser.email != emailController.text) {
            await currentUser.updateEmail(emailController.text);
          }

          if (passwordController.text.isNotEmpty &&
              passwordController.text == confirmPasswordController.text) {
            await currentUser.updatePassword(passwordController.text);
            FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .update({
              'password': passwordController.text,
            });
          }

          setState(() {
            // Refresh the widget after the changes are saved
          });

          showSnackBar('Changes saved successfully');
        }).catchError((error) {
          showSnackBar('Error occurred while saving changes');
        });
      }
    }
  }

  String? _validateEmail(String? value) {
    Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: lnameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: _isHidden,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                TextFormField(
                  obscureText: _isHidden,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                  validator: _validatePassword,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _saveChanges,
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
        ),
      ),
    );
  }
}
