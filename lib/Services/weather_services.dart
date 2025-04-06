import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';

class weatherservices {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apikey = 'bb1d4c5f6fa442aba0a154706230410';
  Future<WeatherModel> getweather({required String cityName}) async {
    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apikey&q=$cityName&days=1');
    http.Response response = await http.get(url);
    // => عمليه تحويل البيانات ال جايه من النت وتعريف المتغيرات التي سوف يتم استدعائهاا
    Map<String, dynamic> data = jsonDecode(response.body);
    // ignore: unused_local_variable
 // this object return data from  file name = models & screen name => weather models
    WeatherModel weather = WeatherModel.fromjson(data);
    return weather;
  }
}
