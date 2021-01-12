import 'package:farmassist/data/farm/models/Forecast.dart';
import 'package:farmassist/data/farm/models/Location.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}
