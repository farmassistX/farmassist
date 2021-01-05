import 'package:farmassist/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:farmassist/ui/farm/weather/weatherSummaryView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cityEntryView.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => Container(
          color: Colors.red,
            height: 200,
            child: ListView(
              children: <Widget>[
                CityEntryView(),
                weatherViewModel.isRequestPending
                    ? buildBusyIndicator()
                    : weatherViewModel.isRequestError
                    ? Center(
                    child: Text('Ooops...something went wrong',
                        style: TextStyle(
                            fontSize: 21, color: Colors.white)))
                    : Column(children: [
                  WeatherSummary(
                      model: weatherViewModel,
                      condition: weatherViewModel.condition,
                      temp: weatherViewModel.temp,
                      feelsLike: weatherViewModel.feelsLike,
                      isdayTime: weatherViewModel.isDaytime,
                      iconData: weatherViewModel.iconData),
                  SizedBox(height: 20),
                ]),
              ],
            )));
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }
}
