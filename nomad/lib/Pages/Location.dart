// import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:location/location.dart';
import 'package:nomad/globalvar.dart' as globals;

class LocationPermission {
  Location _location = new Location();
  double? longitude = 40;
  double? latitude = 40;

  Future<void> getLocation() async {
    // Check location status

    bool _ServiceEnabled = false;
    PermissionStatus _PermissionGranted;

    _ServiceEnabled = await _location.serviceEnabled();
    if (!_ServiceEnabled) {
      _ServiceEnabled = await _location.requestService();
    }
    print(_ServiceEnabled);

    _PermissionGranted = await _location.hasPermission();
    if (_PermissionGranted != PermissionStatus.granted) {
      if (_PermissionGranted == PermissionStatus.denied) {
        _PermissionGranted = await _location.requestPermission();
      }
    }
    print(_PermissionGranted);
    LocationData _LocationData = await _location.getLocation();
    print("LocationData info:");
    print(_LocationData.latitude);
    print(_LocationData.longitude);
    globals.globalLAT = _LocationData.longitude;
    globals.globalLNG = _LocationData.latitude;
  }
}
