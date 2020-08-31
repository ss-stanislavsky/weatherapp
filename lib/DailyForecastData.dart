import 'package:intl/intl.dart';

class DailyForecastData {
  static const String formatToDate = 'EEEE, d MMMM';
  static const String formatToTime = 'HH:mm';
  static const Map<int, String> directions = {0: 'N', 1: 'NW', 2: 'W', 3: 'SW',
    4: 'S', 5: 'SE', 6:'E', 7: 'NE', 8: 'N'};

  DailyForecastData.fromJson(Map<dynamic, dynamic> json, dynamic timezone) :
        this.date = DateTime.fromMillisecondsSinceEpoch((json['dt'] + timezone) * 1000, isUtc: true),
        this.sunrise = DateTime.fromMillisecondsSinceEpoch((json['sunrise'] + timezone) * 1000, isUtc: true),
        this.sunset = DateTime.fromMillisecondsSinceEpoch((json['sunset'] + timezone) * 1000, isUtc: true),
        this.tempDay = (json['temp']['day'] - 273.15).round(),
        this.tempDayMin = (json['temp']['min'] - 273.15).round(),
        this.tempDayMax = (json['temp']['max'] - 273.15).round(),
        this.tempDayFeelsLike = (json['feels_like']['day'] - 273.15).round(),
        this.tempNight = (json['temp']['night'] - 273.15).round(),
        this.tempNightMin = (json['temp']['morn'] - 273.15).round(),
        this.tempNightMax = (json['temp']['eve'] - 273.15).round(),
        this.tempNightFeelsLike = (json['feels_like']['night'] - 273.15).round(),
        this.pressure = json['pressure'],
        this.humidity = json['humidity'],
        this.windSpeed = (json['wind_speed']).round(),
        this.windDirDegrees = json['wind_deg'],
        this.icon = json['weather'][0]['icon'];

  final date;
  final sunrise;
  final sunset;
  final tempDay;
  final tempNight;
  final tempDayMin;
  final tempDayMax;
  final tempDayFeelsLike;
  final tempNightMin;
  final tempNightMax;
  final tempNightFeelsLike;
  final pressure;
  final humidity;
  final windSpeed;
  final windDirDegrees;
  final icon;

  get dateFormatted => DateFormat(formatToDate).format(this.date);
  get sunriseFormatted => DateFormat(formatToTime).format(sunrise);
  get sunsetFormatted => DateFormat(formatToTime).format(sunset);
  get windDirection {
    int index = ((windDirDegrees + 22.5) / 45).floor();
    return directions[index];
  }
}