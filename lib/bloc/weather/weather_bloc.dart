

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_news_app/bloc/weather/weather_event.dart';
import 'package:weather_news_app/bloc/weather/weather_state.dart';
import '../../model/repository/weather_repo.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc({required this.weatherRepo}) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weatherResponse = await weatherRepo.fetchWeather(event.city);
        yield WeatherLoaded(weatherResponse.weather!);
      } catch (e) {
        yield WeatherError(e.toString());
      }
    }
  }
}
