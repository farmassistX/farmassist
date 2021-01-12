import 'dart:convert';

import 'package:farmassist/data/farm/models/Forecast.dart';
import 'package:farmassist/data/farm/models/Location.dart';
import 'package:farmassist/data/farm/services/weather_api.dart';
import 'package:http/http.dart' as http;

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "92ef38427d2c28239bb706af37d77737";
  http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    this.httpClient = new http.Client();
  }

  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.encodeFull(requestUrl));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    return Location.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$apiKey';
    final response = await this.httpClient.get(Uri.encodeFull(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.body));
  }
}
