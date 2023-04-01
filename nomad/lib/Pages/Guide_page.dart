import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:location/location.dart';
import 'package:nomad/Pages/Location.dart';
import 'package:nomad/globalvar.dart' as globals;

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Lat:  ${globals.globalLAT.toString()}'),
          Text('Lng:  ${globals.globalLNG.toString()}'),
          Text('Data: ${globals.data ?? ""}')
        ],
      ),
    );
  }
}
