import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Cubit/Weather_Cubit.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/providers/weather_provider.dart';

class searchpage extends StatelessWidget {
  String? cityName;

// build creen 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1690f8),
        title: const Text(
          'Search a City',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            // ignore: non_constant_identifier_names
            onSubmitted: (data) async {
              cityName = data;

              BlocProvider.of<WeatherCubit>(context)
                  .getweather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25, horizontal: 16),
              border: OutlineInputBorder(),
              label: Text(
                'search',
                style: TextStyle(fontSize: 18),
              ),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    //1- هنا انا استدعيت الكلاس المسؤل عن جلب اليبانات من النت وعملت ليه object
                    weatherservices service = weatherservices();
                    //2- استدعيت الكلاس المسؤال عن بيانات والتغيرات ال هتحصل فالبرنامج واعطتئه object
                    // وقولتله مش هتنفذ الكود غير لما تجيب البيانات من رقم1 من خلال ال object
                    WeatherModel weather =
                        await service.getweather(cityName: cityName!);
                    // 3- استدعاء ال  provider  ومن خلال المتغير المتعرف جواه هساويه ب متغير رقم
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = cityName;
                    // used for return
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search)),
              hintText: 'Enter a City',
            ),
          ),
        ),
      ),
    );
  }
}
