import 'package:farmassist/app_theme.dart';
import 'package:farmassist/data/IoT/models/telemetry_data.dart';
import 'package:farmassist/ui/IoT/reload_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TelemetryDataReading extends StatelessWidget {
  const TelemetryDataReading({this.reloadTime});

  final ReloadTime reloadTime;

  @override
  Widget build(BuildContext context) {
    TelemetryData telemetryData = context.watch<TelemetryData>();

    if (telemetryData == null) {
      return _buildReading('N/A');
    } else {
      Future.delayed(Duration.zero, () => reloadTime.update());
      return _buildReading(telemetryData.value);
    }
  }

  Text _buildReading(String reading) {
    return Text(
      reading,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontFamily: AppTheme.fontName,
        fontWeight: FontWeight.w500,
        fontSize: 50,
        letterSpacing: 0.0,
        color: AppTheme.white,
      ),
    );
  }
}
