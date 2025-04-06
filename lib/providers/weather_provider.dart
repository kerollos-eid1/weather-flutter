import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
// دا المسؤال عن ارسال واستقبال البيانات  
class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;
  String? cityName;
  set weatherData(WeatherModel? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;
}
