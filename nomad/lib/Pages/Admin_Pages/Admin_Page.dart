import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:nomad/Pages/Admin_Pages/Reports_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.blue,
            child: TextButton(
                child: const Text(
                  'List of Proposals',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProposalPage()));
                }),
          ),
          Card(
            color: Colors.blue,
            child: TextButton(
                child: const Text(
                  'List of Reports',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportsPage()));
                }),
          )
        ],
      ),
    );
  }
}
