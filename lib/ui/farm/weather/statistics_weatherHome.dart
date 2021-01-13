import 'package:farmassist/data/farm/models/Weather.dart';
import 'package:farmassist/data/farm/view_model/weather_app_forecast_viewmodel.dart';
import 'package:farmassist/ui/farm/weather/weatherSummaryView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DailySummaryView.dart';
import 'cityEntryView.dart';
import 'gradient.dart';

class WeatherHomeStatistics extends StatefulWidget {
  @override
  _WeatherHomeStatisticsState createState() => _WeatherHomeStatisticsState();
}

class _WeatherHomeStatisticsState extends State<WeatherHomeStatistics> {
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
            height: 160,
            child: ListView(
              children: <Widget>[
                weatherViewModel.daily==null
                    ? Center(
                    child: Text('Ooops...something went wrong',
                        style: TextStyle(
                            fontSize: 21, color: Colors.white)))
                    : Column(children:[
                  buildDailySummary(weatherViewModel.daily)
                  ],
                ),
              ],
            )
        )
    );
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DailySummaryView(weather: dailyForecast[0]),
              DailySummaryView(weather: dailyForecast[1]),
              DailySummaryView(weather: dailyForecast[2]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DailySummaryView(weather: dailyForecast[3]),
              DailySummaryView(weather: dailyForecast[4]),
              DailySummaryView(weather: dailyForecast[5]),
            ],
          )
        ]
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
