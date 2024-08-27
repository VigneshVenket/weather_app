
import 'package:dio/dio.dart';
import '../response/news_response.dart';
import '../response/weather_response.dart';
import 'logging_interceptor.dart';

class ApiProvider{

  final String weatherApiKey="b695b0dfb1d74e68f3937a6588127509";
  final String newsApiKey="a1922436f19a4a5bbcc805d1de34f811";

  Dio? _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(
      receiveTimeout: Duration(milliseconds: 3000),
      connectTimeout: Duration(milliseconds: 3000),
      validateStatus: (status) => true,
      followRedirects: false,
    );
    _dio = Dio(options);
    _dio!.interceptors.add(LoggingInterceptor());
  }

  String _handleError(error) {

    String errorDescription = "";

    if (error is DioException) {
      if (error is DioExceptionType) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorDescription = "Connection timeout with API server";
            break;
          case DioExceptionType.sendTimeout:
            errorDescription = "Send timeout in connection with API server";
            break;
          case DioExceptionType.receiveTimeout:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioExceptionType.badResponse:
            errorDescription =
            "Received invalid status code: ${error.response?.statusCode}";
            break;
          case DioExceptionType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioExceptionType.badCertificate:
            errorDescription="SSL certificate validation failed : ${error.response?.statusMessage}";
          case DioExceptionType.connectionError:
            errorDescription="Connection timeout: ${error.response?.statusMessage}";
          case DioExceptionType.unknown:
            errorDescription="Unknown error occured";
        }
      }
      else {
        errorDescription = "Unexpected Error Occurred";
      }
    } else {
      errorDescription = error.toString();
    }
    return errorDescription;
  }

  Future<WeatherResponse> fetchWeather(String city) async {
    try {
      Response response = await _dio!.get('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$weatherApiKey&units=metric');
      return WeatherResponse.fromJson(response.data);
    } catch (error) {
      throw Exception(_handleError(error));
    }
  }

  Future<NewsResponse> fetchNews() async {
    try {
      Response response = await _dio!.get('https://newsapi.org/v2/top-headlines?apiKey=$newsApiKey&language=en');
      return NewsResponse.fromJson(response.data);
    } catch (error) {
      throw Exception(_handleError(error));
  }
  }

}