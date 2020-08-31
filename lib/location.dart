import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  Location location = Location();

  bool _isServiceEnabled;
  PermissionStatus _isPermissionGranted;
  LocationData _locationData;

  _isServiceEnabled = await location.serviceEnabled();
  if (!_isServiceEnabled) {
    _isServiceEnabled = await location.requestService();
    if (!_isServiceEnabled) return _locationData;
  }

  _isPermissionGranted = await location.hasPermission();
  if (_isPermissionGranted == PermissionStatus.denied) {
    _isPermissionGranted = await location.requestPermission();
    if (_isPermissionGranted != PermissionStatus.granted) return _locationData;
  }

  _locationData = await location.getLocation();
  return _locationData;
}