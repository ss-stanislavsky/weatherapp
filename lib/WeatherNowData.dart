import 'package:intl/intl.dart';

class WeatherNowData {
  static const String formatToDate = 'EEEE, d MMMM, y, HH:mm';
  static const String formatToTime = 'HH:mm';
  static const Map<int, String> directions = {0: 'N', 1: 'NW', 2: 'W', 3: 'SW',
                                  4: 'S', 5: 'SE', 6:'E', 7: 'NE', 8: 'N'};

  WeatherNowData.fromJson(Map<dynamic, dynamic> json) :
      this.description = json['weather'][0]['description'],
      this.icon = json['weather'][0]['icon'],
      this.temp = (json['main']['temp'] - 273.15).round(),
      this.tempMin = (json['main']['temp_min'] - 273.15).round(),
      this.tempMax = (json['main']['temp_max'] - 273.15).round(),
      this.pressure = json['main']['pressure'],
      this.humidity = json['main']['humidity'],
      this.windDirDegrees = json['wind']['deg'],
      this.windSpeed = (json['wind']['speed']).round(),
      this.date = DateTime.fromMillisecondsSinceEpoch((json['dt'] + json['timezone']) * 1000, isUtc: true),
      this.sunrise = DateTime.fromMillisecondsSinceEpoch((json['sys']['sunrise'] + json['timezone']) * 1000, isUtc: true),
      this.sunset = DateTime.fromMillisecondsSinceEpoch((json['sys']['sunset'] + json['timezone']) * 1000, isUtc: true),
      this.location = json['name'],
      this.country = json['sys']['country'];

  final description;
  final icon;
  final temp;
  final tempMin;
  final tempMax;
  final pressure;
  final humidity;
  final windSpeed;
  final windDirDegrees;
  final date;
  final sunrise;
  final sunset;
  final location;
  final country;

  get dateFormatted => DateFormat(formatToDate).format(this.date);
  get sunriseFormatted => DateFormat(formatToTime).format(sunrise);
  get sunsetFormatted => DateFormat(formatToTime).format(sunset);
  //return wind direction in points instead of degrees
  get windDirection {
    int index = (windDirDegrees / 45).round();
    return directions[index];
  }
}