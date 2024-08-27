


import '../api/api_provider.dart';
import '../response/weather_response.dart';

class WeatherRepo{

  ApiProvider apiProvider=ApiProvider();

  Future<WeatherResponse>  fetchWeather(String city){
    return apiProvider.fetchWeather(city);
  }

}