
import 'package:flutter/material.dart';

class Recommender extends StatelessWidget {
  const Recommender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          // color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Recommender"),
        centerTitle: true,
      ),
    );
  }
}
