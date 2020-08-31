import 'package:flutter/material.dart';
import 'package:weatherapp/DailyForecastData.dart';

class DailyForecastScreen extends StatefulWidget {
  DailyForecastScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DailyForecastScreenState();
}

class DailyForecastScreenState extends State<DailyForecastScreen> {
  static const TextStyle upRowStyle =
  TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const TextStyle downRowStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);

  List<DailyForecastData> _data = List();

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

  void updateState(List<DailyForecastData> data) {
    setState(() => this._data = data);
  }

  Widget buildCardView(BuildContext context, int index) {
    return Container(
      //height: 100,
      //color: Colors.deepOrange[500],
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
            //'30 August',
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
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildInfoImage(index, [
            _data[index].sunsetFormatted, _data[index].sunriseFormatted
          ]),
          buildInfoTempColumn(index, [
            '${_data[index].tempDay}\u00b0', '${_data[index].tempNight}\u00b0',
            '${_data[index].tempDayMin}\u00b0', '${_data[index].tempNightMin}\u00b0',
            '${_data[index].tempDayMax}\u00b0', '${_data[index].tempNightMax}\u00b0',
            '${_data[index].tempDayFeelsLike}\u00b0', '${_data[index].tempNightFeelsLike}\u00b0',
          ]),
          buildInfoColumns(index, [
            '${_data[index].windSpeed} m/s', _data[index].windDirection,
            '${_data[index].pressure} hPa', '${_data[index].humidity} %'
          ]),
        ],
      ),
    );
  }

  Widget buildInfoImage(int index, List<String> info) {
    const TextStyle upRowStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    const TextStyle downRowStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 95,
          child: Image.network(
            'http://openweathermap.org/img/wn/${_data[index].icon}@2x.png',
            //'http://openweathermap.org/img/wn/10d@2x.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[0], style: upRowStyle,),
              Text('sunset', style: downRowStyle,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[1], style: upRowStyle,),
              Text('sunrise', style: downRowStyle,),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoTempColumn(int index, List<String> info) {
    return Container(
      width: 100,
      child: Column(
      children: [
        buildInfoTempColumnChild(index, 'Day', 'Night'),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: buildInfoTempColumnChild(index, info[0], info[1]),
        ),
        Text('average', style: downRowStyle,),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: buildInfoTempColumnChild(index, info[2], info[3]),
        ),
        Text('minimal', style: downRowStyle,),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: buildInfoTempColumnChild(index, info[4], info[5]),
        ),
        Text('maximal', style: downRowStyle,),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: buildInfoTempColumnChild(index, info[6], info[7]),
        ),
        Text('feels like', style: downRowStyle,),
      ],
    ),
    );
  }

  Widget buildInfoTempColumnChild(int index, String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(first, style: upRowStyle,),
        Padding(padding: EdgeInsets.only(left: 5, right: 5),),
        Text(second, style: upRowStyle,),
      ],
    );
  }

  Widget buildInfoColumns(int index, List<String> info) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[0], style: upRowStyle,),
              Text('wind sp', style: downRowStyle,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[1], style: upRowStyle,),
              Text('wind dir', style: downRowStyle,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[2], style: upRowStyle,),
              Text('pressure', style: downRowStyle,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(info[3], style: upRowStyle,),
              Text('humidity', style: downRowStyle,),
            ],
          ),
        ),
      ],
    );
  }
}
