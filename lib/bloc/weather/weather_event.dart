

abstract class WeatherEvent {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {

  final String city;

  const FetchWeather(this.city);

}
