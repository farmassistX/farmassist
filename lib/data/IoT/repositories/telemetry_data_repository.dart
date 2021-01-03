import 'package:farmassist/data/IoT/models/telemetry_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TelemetryDataRepository {
  TelemetryDataRepository() {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    firebaseDatabase.setPersistenceEnabled(true);
    _telemetryDb = firebaseDatabase
        .reference()
        .child('telemetry_data')
        .child(FirebaseAuth.instance.currentUser.uid);
  }

  DatabaseReference _telemetryDb;

  Stream<TelemetryData> readData(String data) {
    return _telemetryDb
        .child(data)
        .orderByKey()
        .onChildAdded
        .map((event) => TelemetryData.fromRealtimeDatabase(event.snapshot));
  }

  TelemetryData readPreviousReading(String data) {
    TelemetryData telemetryData;
    _telemetryDb
        .child(data)
        .orderByKey()
        .limitToLast(1)
        .onChildAdded
        .forEach((event) {
      if (event.snapshot != null) {
        telemetryData = TelemetryData.fromRealtimeDatabase(event.snapshot);
      }
    });
    return telemetryData;
  }

  List<TelemetryData> readPreviousReadings(String data, int num) {
    List<TelemetryData> telemetryDataList = List();
    _telemetryDb
        .child(data)
        .orderByKey()
        .limitToLast(num)
        .onValue
        .forEach((event) {
      if (event.snapshot != null && event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value;
        map = Map.fromEntries(map.entries.toList()
          ..sort((e1, e2) => int.parse(e1.key).compareTo(int.parse(e2.key))));
        map.forEach((key, value) {
          telemetryDataList.add(TelemetryData.from(key, value));
        });
      }
    });
    return telemetryDataList;
  }
}
