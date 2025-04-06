import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/Cubit/Weather_Cubit.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/pages/home_page.dart';

void main() {
  runApp(
    BlocProvider(
        create: (context) {
          return WeatherCubit(weatherservices());
        },
        child: weatherapp()),
  );
}

class weatherapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch:
              BlocProvider.of<WeatherCubit>(context).weatherModel == null
                  ? Colors.blue
                  : BlocProvider.of<WeatherCubit>(context, listen: true)
                      .weatherModel!
                      .getShemeColor()),
      home: HomePage(),
    );
  }
}
