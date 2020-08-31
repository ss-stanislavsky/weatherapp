import 'package:flutter/material.dart';
import 'HourlyForecastData.dart';

class HourlyForecastScreen extends StatefulWidget {
  HourlyForecastScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HourlyForecastScreenState();
}

class HourlyForecastScreenState extends State<HourlyForecastScreen> {
  List<HourlyForecastData> _data = List();

  @override
  Widget build(BuildContext context) {
    if (_data.length != 0) {
      return Container(
        padding: EdgeInsets.all(2),
          color: Colors.deepOrange[50],
          child: ListView.builder(
            //padding: EdgeInsets.all(10),
            itemCount: _data.length,
            itemBuilder: (context, index) => buildCardView(context, index),
          ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void updateState(List<HourlyForecastData> data) {
    setState(() => this._data = data);
  }

    Widget buildCardView(BuildContext context, int index) {
      return Container(
        child: Card(
          elevation: 10,
          color: Colors.deepOrange[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDateSection(index),
              Divider(),
              buildInformationSection(index),
            ],
          ),
        ),
      );
    }

    Widget buildDateSection(int index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(25, 5, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _data[index].dateFormatted,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildInformationSection(int index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildInfoImage(index),
            buildInfoColumns(index, [
              '${_data[index].temp}\u00b0', 'temp',
              '${_data[index].tempFeelsLike}\u00b0', 'feels like']),
            buildInfoColumns(index, [
              '${_data[index].windSpeed} m/s', 'wind sp',
              '${_data[index].windDirection}', 'wind dir']),
            buildInfoColumns(index, [
              '${_data[index].pressure} hPa', 'pressure',
              '${_data[index].humidity} %', 'humidity']),
          ],
        ),
      );
    }

    Widget buildInfoImage(int index) {
      return Container(
        height: 75,
        child: Image.network(
          'http://openweathermap.org/img/wn/${_data[index].icon}@2x.png',
          fit: BoxFit.cover,
        ),
      );
    }

    Widget buildInfoColumns(int index, List<String> info) {
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
