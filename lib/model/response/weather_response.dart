
import '../data_models/weather.dart';

class WeatherResponse {
  Weather? weather;

  WeatherResponse({required this.weather});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    weather= Weather.fromJson(json);
  }
}
