import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  TextEditingController userIDController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool _isBanned = false;

  void _banUser() {
    setState(() {
      _isBanned = true;
    });
  }

  void _unbanUser() {
    setState(() {
      _isBanned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Ban Banner'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'User ID',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: userIDController,
              decoration: InputDecoration(
                hintText: ' user ID will be here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Comment',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'comment will be here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _isBanned ? null : _banUser,
                  child: Text('Ban'),
                ),
                ElevatedButton(
                  onPressed: _isBanned ? _unbanUser : null,
                  child: Text('cancellation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
