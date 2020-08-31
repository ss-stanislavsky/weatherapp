import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

const String key = 'a57825a03761e68d8f1647e9324449c1';
// Kharkiv coordinates
const double defaultLatitude = 49.988358;
const double defaultLongitude = 36.232845;

Future<bool> isInternetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    print('isInternetAvailable true');
    return true;
  }
  else {
    print('isInternetAvailable false');
    return false;
  }
}

Future<Map<dynamic, dynamic>> getWeather({List<String> baseUrl, LocationData locationData}) async {
  String locationForRequest;

  if (locationData != null)
    locationForRequest = '?lat=${locationData.latitude}&lon=${locationData.longitude}';
  else
    locationForRequest = '?lat=$defaultLatitude&lon=$defaultLongitude';

  print('location: $locationForRequest');

  var response = await http.get(
      '${baseUrl.elementAt(0)}'
      '$locationForRequest'
      '${baseUrl.elementAt(2)}'
      '&appid=$key');

  var map = json.decode(response.body) as Map;
  return map;
}