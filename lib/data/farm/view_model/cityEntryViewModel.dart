import 'package:farmassist/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class CityEntryViewModel with ChangeNotifier {
  String _city;

  CityEntryViewModel();

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather(_city);

    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}
