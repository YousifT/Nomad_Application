
import 'package:flutter/material.dart';

class PackagePlans extends StatelessWidget {
  const PackagePlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          // color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Package Plans"),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
