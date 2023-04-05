import 'package:flutter/material.dart';

class MyPlans extends StatelessWidget {
  const MyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          // color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("My Plans"),
        centerTitle: true,
      ),
    );
  }
}
