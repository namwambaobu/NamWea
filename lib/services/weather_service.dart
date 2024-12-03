import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:nam_wea/models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://home.openweathermap.org/api_keys';
  final String api_Key;

  WeatherService(this.api_Key);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Url.parse('$BASE_URL?q=$cityName appid=$api_Key units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load weather data');
    }
  }
}
