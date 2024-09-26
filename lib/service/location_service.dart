import 'dart:js_interop';

import 'package:location/location.dart';

class LocationService {
  static Future<bool> isLocationEnabled() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return true;
      }
    }

    return false;
  }

  static Future<String> getLocation() async {
   var locationEnabled = await LocationService.isLocationEnabled();
   if (!locationEnabled) {
     return "Location not enabled";
   }

   return Location().getLocation().toString();
  }

  static Future<LocationData> findLocation() async {
    var loc = Location().getLocation();
    return loc;
  }
}