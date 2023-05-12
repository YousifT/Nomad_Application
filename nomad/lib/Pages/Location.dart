// import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:location/location.dart';
import 'package:nomad/Global_Var.dart' as globals;

class LocationPermission {
  Location _location = new Location();
  double? longitude = 0;
  double? latitude = 0;

  Future<void> getLocation() async {
    // Check location status

    bool _ServiceEnabled = false;
    PermissionStatus _PermissionGranted;

    _ServiceEnabled = await _location.serviceEnabled();
    if (!_ServiceEnabled) {
      _ServiceEnabled = await _location.requestService();
    }

    _PermissionGranted = await _location.hasPermission();
    if (_PermissionGranted != PermissionStatus.granted) {
      if (_PermissionGranted == PermissionStatus.denied) {
        _PermissionGranted = await _location.requestPermission();
      }
    }
    LocationData _LocationData = await _location.getLocation();
    print(
        "Setting location info: ${_LocationData.latitude} & ${_LocationData.longitude}");

    if (_LocationData.latitude! < 0 || _LocationData.longitude! < 0) {
      globals.global_Latitude = 26.3145;
      globals.global_Longitude = 50.1447;
    } else {
      globals.global_Latitude = _LocationData.latitude;
      globals.global_Longitude = _LocationData.longitude;
    }
  }
}
