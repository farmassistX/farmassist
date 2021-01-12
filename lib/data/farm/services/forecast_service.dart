import 'package:farmassist/data/farm/models/Forecast.dart';
import 'package:farmassist/data/farm/services/weather_api.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(String city) async {
    final location = await weatherApi.getLocation(city);
    return await weatherApi.getWeather(location);
  }
}
