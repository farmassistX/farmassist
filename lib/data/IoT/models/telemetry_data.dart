import 'package:firebase_database/firebase_database.dart';

class TelemetryData {
  const TelemetryData({this.timestamp, this.value});

  final DateTime timestamp;
  final String value;

  factory TelemetryData.fromRealtimeDatabase(DataSnapshot data) {
    return TelemetryData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(data.key)),
      value: data.value,
    );
  }

  factory TelemetryData.from(String timestamp, String value) {
    return TelemetryData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)),
      value: value,
    );
  }
}
