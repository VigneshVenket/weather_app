

import '../../model/data_models/weather.dart';

abstract class WeatherState{
  const WeatherState();

}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

}
