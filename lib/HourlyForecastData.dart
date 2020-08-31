import 'package:intl/intl.dart';

class HourlyForecastData {
  static const String formatToDate = 'HH:mm, d MMMM, EEE';
  static const Map<int, String> directions = {0: 'N', 1: 'NW', 2: 'W', 3: 'SW',
    4: 'S', 5: 'SE', 6:'E', 7: 'NE', 8: 'N'};

  HourlyForecastData.fromJson(Map<dynamic, dynamic> json, dynamic timezone) :
        this.date = DateTime.fromMillisecondsSinceEpoch((json['dt'] + timezone) * 1000, isUtc: true),
        this.temp = (json['temp'] - 273.15).round(),
        this.tempFeelsLike = (json['feels_like'] - 273.15).round(),
        this.pressure = json['pressure'],
        this.humidity = json['humidity'],
        this.windSpeed = (json['wind_speed']).round(),
        this.windDirDegrees = json['wind_deg'],
        this.icon = json['weather'][0]['icon'];

  final date;
  final temp;
  final tempFeelsLike;
  final pressure;
  final humidity;
  final windSpeed;
  final windDirDegrees;
  final icon;

  get dateFormatted => DateFormat(formatToDate).format(this.date);
  //return wind direction in points instead of degrees
  get windDirection {
    int index = (windDirDegrees / 45).round();
    return directions[index];
  }
}
