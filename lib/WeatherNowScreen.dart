import 'package:flutter/material.dart';
import 'package:weatherapp/WeatherNowData.dart';
//import 'package:weatherapp/Data.dart';

class WeatherNowScreen extends StatefulWidget {
  WeatherNowScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeatherNowScreenState();
}

class WeatherNowScreenState extends State<WeatherNowScreen> {
  static const List<String> url = ['https://api.openweathermap.org/data/2.5/weather', '', ''];
  WeatherNowData _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        color: Colors.deepOrange[100],
          child: ListView(
            children: [
              locationSection(),
              dateSection(),
              imageSection(),
              descriptionSection(),
              temperatureSection(),
              moreInformationSection(),
            ],
          ),
      );
    }
  }

  updateState(WeatherNowData data) {
    setState(() { this._data = data; });
  }

  Widget locationSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_data.location.toUpperCase()}, ${_data.country}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
        ),
      ],
    );
  }

  Widget dateSection() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _data.dateFormatted,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400,),
          ),
        ],
      ),
    );
  }

  Widget imageSection() {
    return Container(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            'http://openweathermap.org/img/wn/${_data.icon}@2x.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget descriptionSection() {
    String s = _data.description;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.substring(0, 1).toUpperCase() + s.substring(1),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,),
        ),
      ],
    );
  }

  Widget temperatureSection() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${_data.temp.toString()}\u00b0',
            style: TextStyle(fontSize: 120, fontWeight: FontWeight.w300,),
          ),
          Row(
            children: [
              buildTempSectionColumn(_data.tempMin.toString(), 'min\nat now'),
              buildTempSectionColumn(_data.tempMax.toString(), 'max\nat now'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTempSectionColumn(String value, String temp) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$value\u00b0',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          Text(
            temp,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget moreInformationSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildMoreInfoSectionColumn([
          '${_data.windSpeed.toString()} m/s', 'wind sp',
          '${_data.windDirection.toString()}\u00b0', 'wind dir'
        ]),
        buildMoreInfoSectionColumn([
          _data.sunriseFormatted, 'sunrise',
          _data.sunsetFormatted, 'sunset'
        ]),
        buildMoreInfoSectionColumn([
          '${_data.pressure.toString()} hPa', 'pressure',
          '${_data.humidity.toString()} %', 'humidity'
        ]),
      ],
    );
  }

  Widget buildMoreInfoSectionColumn(List<String> info) {
    const TextStyle upRowStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    const TextStyle downRowStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);

    return Column(
      children: [
        Text(info[0], style: upRowStyle,),
        Text(info[1], style: downRowStyle,),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[2], style: upRowStyle,),
              Text(info[3], style: downRowStyle,),
            ],
          ),
        ),
      ],
    );
  }
}
