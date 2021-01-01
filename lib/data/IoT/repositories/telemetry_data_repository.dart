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
        .orderByValue()
        .onChildAdded
        .map((event) => TelemetryData.fromRealtimeDatabase(event.snapshot));
  }
}
