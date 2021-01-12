import 'package:farmassist/ui/farm/statistics/widget/calendarHome.dart';
import 'package:farmassist/ui/farm/weather/statistics_weatherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class StatisticsPageOne extends StatefulWidget {
  @override
  _StatisticsPageOneState createState() => _StatisticsPageOneState();
}

class _StatisticsPageOneState extends State<StatisticsPageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WeatherHomeStatistics(),
        CalendarScreen(),
      ],
    );
  }
}
