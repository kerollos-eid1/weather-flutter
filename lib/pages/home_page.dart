import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/Cubit/Weather_Cubit.dart';
import 'package:weather_app/Cubit/Weather_state.dart';
import 'package:weather_app/models/weather_models.dart';

import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            /**
         * بقوله انت هتشوف الويزر لو مش في داتا خلي اللون الافتراضي ازرق 
         * لكن لو جاي بقيمه خليه ياخد لون الويزر ال جاي 
         */
            BlocProvider.of<WeatherCubit>(context).weatherModel == null
                ? Colors.blue
                : BlocProvider.of<WeatherCubit>(context)
                    .weatherModel!
                    .getShemeColor(),
        title: Text(
          'Weather app',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return searchpage();
                }),
              );
            },
          )
        ],
      ),

      // return data from weather provider
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is Weatherloading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccessInformation) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return successBody(weatherData: weatherData);
          } else if (state is WeatherFailureInformation) {
            return Center(
              child: Text(' somthing Worng  Please try again'),
            );
          } else {
            return DefualtHomePage();
          }
        },
      ),
    );
  }
}

class DefualtHomePage extends StatelessWidget {
  const DefualtHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There is no weather😔',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            'start Searching Now 🔍',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class successBody extends StatelessWidget {
  const successBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData!.getShemeColor(),
            weatherData!.getShemeColor()[300]!,
            weatherData!.getShemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName ?? '',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weatherData!.date.hour.toString()} : ${weatherData!.date.minute.toString()}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getimages()),
              Text(
                weatherData?.temp.toInt().toString() ?? '',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    'maxtemp : ${weatherData!.maxtemp.toInt()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'mintemp : ${weatherData!.mintemp.toInt()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Spacer(
            flex: 2,
          ),
          Text(
            weatherData?.text ?? '',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 6),
        ],
      ),
    );
  }
}
