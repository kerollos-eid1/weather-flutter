// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// this model turn on the services screen  name => weather services its mission get the data in internet through api
class WeatherModel {
  DateTime date;
  double temp;
  double maxtemp;
  double mintemp;
  String text;

  // ths is normal constructor class
  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxtemp,
      required this.mintemp,
      required this.text});
// this factory constructor is reuten data in api from internet  on constructor class
  factory WeatherModel.fromjson(dynamic data) {
    var jsondate = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
        date: DateTime.parse(data['location']['localtime']),
        temp: jsondate['avgtemp_c'],
        maxtemp: jsondate['maxtemp_c'],
        mintemp: jsondate['mintemp_c'],
        text: jsondate['condition']['text']);
  }
  @override
  String toString() {
    return 'date = $date  temp =$temp maxtemp=$maxtemp mintemp =$mintemp text =$text';
  }

  String getimages() {
    if (text == 'Snow' || text == 'Hail' || text == 'Sleet') {
      return 'assets/images/snow.png';
    } else if (text == 'Rainy' || text == 'Moderate rain') {
      return 'assets/images/rainy.png';
    } else if (text == 'Cloudy' || text == 'Heavy Cloudy') {
      return 'assets/images/cloudy.png';
    } else if (text == 'Clear' || text == 'Light Cloudy') {
      return 'assets/images/clear.png';
    } else if (text == 'Sunny') {
      return 'assets/images/clear.png';
    } else if (text == 'Thunderstorm' || text == 'Thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/thunderstorm.png';
    }
  }

  MaterialColor getShemeColor() {
    if (text == 'Snow' || text == 'Hail' || text == 'Sleet') {
      return Colors.orange;
    } else if (text == 'Rainy' || text == 'Moderate rain') {
      return Colors.blue;
    } else if (text == 'Cloudy' || text == 'Heavy cloudy') {
      return Colors.blueGrey;
    } else if (text == 'Clear' || text == 'Light cloud') {
      return Colors.blue;
    } else if (text == 'Thunderstorm' || text == 'Thunder') {
      return Colors.blueGrey;
    } else if (text == 'Sunny') {
      return Colors.orange;
    } else {
      return Colors.blue;
    }
  }
}
