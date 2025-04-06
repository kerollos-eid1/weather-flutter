import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Cubit/Weather_state.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/models/weather_models.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.WeatherServices) : super(Weatherinitial());
  weatherservices WeatherServices;
  String? cityName;
  WeatherModel? weatherModel;
  void getweather({required String cityName}) async {
    emit(Weatherloading());
    try {
      weatherModel = await WeatherServices.getweather(cityName: cityName);
      emit(WeatherSuccessInformation());
    } on Exception catch (e) {
      emit(WeatherFailureInformation());
    }
  }
}
