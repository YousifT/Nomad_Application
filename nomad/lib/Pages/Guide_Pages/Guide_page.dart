import 'package:flutter/material.dart';

import 'package:nomad/Pages/Guide_Pages/MyPlans_page.dart';
import 'package:nomad/Pages/Guide_Pages/PackagePlans_Page.dart';
import 'package:nomad/Pages/User_Pages/Proposal_Form.dart';
import 'package:nomad/Pages/Guide_Pages/Recommender_page.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Recommender(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                fixedSize: const Size.fromHeight(50),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontStyle: FontStyle.italic),
              ),
              child: const Text('Recommender'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProposalForm(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                fixedSize: const Size.fromHeight(50),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontStyle: FontStyle.italic),
              ),
              child: const Text('Package Plans'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPlans(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                fixedSize: const Size.fromHeight(50),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontStyle: FontStyle.italic),
              ),
              child: const Text('My Plans'),
            ),
          ],
        ),
      ),
    );
  }
}
