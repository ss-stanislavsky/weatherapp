import 'package:flutter/material.dart';
import 'package:weatherapp/DailyForecastData.dart';
import 'package:weatherapp/DailyForecastScreen.dart';
import 'package:weatherapp/HourlyForecastData.dart';
import 'package:weatherapp/HourlyForecastScreen.dart';
import 'package:weatherapp/WeatherNowData.dart';
//import 'package:weatherapp/Data.dart';
import 'package:weatherapp/WeatherNowScreen.dart';
import 'connection.dart';
import 'location.dart';

class App extends StatelessWidget {
  static const _title = 'Weather Forecast';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(title: _title),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  static const List<String> weatherUrl = [
    'https://api.openweathermap.org/data/2.5/weather', '', ''];
  static const List<String> forecastUrl = [
    'https://api.openweathermap.org/data/2.5/onecall', '', '&exclude=current,minutely'];

  SnackBar _snackBar;
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  final GlobalKey<WeatherNowScreenState> _keyWeatherNow = GlobalKey();
  final GlobalKey<HourlyForecastScreenState> _keyHourlyForecast = GlobalKey();
  final GlobalKey<DailyForecastScreenState> _keyDailyForecast = GlobalKey();

  static int _currentIndex = 1;
  static WeatherNowData _weatherNowData;
  static List<HourlyForecastData> _hourlyForecastData;
  static List<DailyForecastData> _dailyForecastData;

  void onBottomBarItemTap(int index) {
    setState(() => _currentIndex = index);
  }

  Future<Null> getWeatherData() async {
    var weatherMap = Map();
    var forecastMap = Map();
    var location;

    location = await getLocation();
    if (location == null) {
      buildSnackBar(content: "Can't receive location. The default value will be used.");
    }
    if (await isInternetAvailable()) {
      weatherMap = await getWeather(baseUrl: weatherUrl, locationData: location);
      forecastMap = await getWeather(baseUrl: forecastUrl, locationData: location);
    } else {
      buildSnackBar(content: "No internet connection available. Can't receive weather data." );
    }

    print('Weather weatherMap: $weatherMap');
    print('Forecast forecastMap: $forecastMap');

    setState(() {
      _weatherNowData = WeatherNowData.fromJson(weatherMap);

      _hourlyForecastData = ((forecastMap['hourly'] as List).map((index) =>
      HourlyForecastData.fromJson(index, forecastMap['timezone_offset']))).toList();

      _dailyForecastData =((forecastMap['daily'] as List).map((index) =>
      DailyForecastData.fromJson(index, forecastMap['timezone_offset']))).toList();
    });

    _keyWeatherNow.currentState.updateState(_weatherNowData);
    _keyHourlyForecast.currentState.updateState(_hourlyForecastData);
    _keyDailyForecast.currentState.updateState(_dailyForecastData);

    //print(forecastMap.runtimeType);
    //print(forecastMap['hourly'].runtimeType);
    //print(forecastMap['hourly']);

    print('WeatherData: $_weatherNowData');
    print('weatherMap: ${weatherMap['name']}');

    print('HourlyForecastData: $_hourlyForecastData');
    print('DailyForecastData: $_dailyForecastData');
  }

  @override
  void initState() {
    super.initState();
    /*if(_weatherNowData == null)*/
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () => getWeatherData(),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              Center(child: Text('Coming soon...')),
              WeatherNowScreen(key: _keyWeatherNow,),
              HourlyForecastScreen(key: _keyHourlyForecast,),
              DailyForecastScreen(key: _keyDailyForecast,),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.deepOrange[100],
      bottomNavigationBar: getNavigationBar(),
    );
  }

  Widget getNavigationBar() {
    return BottomNavigationBar(
      items: [
        buildNavBarItem(Icons.history, 'History'),
        buildNavBarItem(Icons.home, 'Weather now'),
        buildNavBarItem(Icons.access_time, 'Hourly Forecast'),
        buildNavBarItem(Icons.today, 'Daily Forecast'),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.deepOrange[800],
      unselectedItemColor: Colors.deepOrange,
      type: BottomNavigationBarType.shifting,
      onTap: (index) => onBottomBarItemTap(index),
    );
  }

  BottomNavigationBarItem buildNavBarItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(title),
      backgroundColor: Colors.deepOrange[100],
    );
  }

  void buildSnackBar({String content}) {
    _snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    //Scaffold.of(context).showSnackBar(_snackBar);
    _keyScaffold.currentState.showSnackBar(_snackBar);
  }
}
