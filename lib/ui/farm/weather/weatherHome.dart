import 'package:farmassist/data/farm/models/Weather.dart';
import 'package:farmassist/data/farm/view_model/cityEntryViewModel.dart';
import 'package:farmassist/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:farmassist/ui/farm/weather/weatherSummaryView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cityEntryView.dart';
import 'gradient.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Container(
        child: _buildGradientContainer(
            model.condition, model.isDaytime, buildHomeView(context, model)),
      ),
    );
  }

  @override
  Widget buildHomeView(BuildContext context, model) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => Container(
            height: 225,
            child: RefreshIndicator(
              color: Colors.transparent,
              backgroundColor: Colors.transparent,
              onRefresh: () => refreshWeather(weatherViewModel, context),
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
                      condition: weatherViewModel.condition,
                      temp: weatherViewModel.temp,
                      feelsLike: weatherViewModel.feelsLike,
                      isdayTime: weatherViewModel.isDaytime,
                      iconData: weatherViewModel.iconData,
                      // weatherModel: model,
                    ),
                  ]),
                ],
              ),
            )
        )
    );
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

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    return weatherVM.getLatestWeather(city);
  }

  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (isDayTime != null && !isDayTime)
      container = GradientContainer(color: Colors.blueGrey, child: child);
    else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}
