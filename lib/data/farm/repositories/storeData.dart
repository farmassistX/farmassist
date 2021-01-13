import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

List months =
['January', 'February', 'March', 'April', 'May','June','July','August','September','October','November','December'];

void addData(Map<String, dynamic> obj) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  double estimate;
  DateTime futureDate;
  int day;

  User user = auth.currentUser;
  final uid = user.uid;

  DateTime dt = obj['plantDate'];
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(dt);

  estimate = obj['plantEstimated'];
  day = estimate.round() * 7;
  futureDate = dt.add(new Duration(days: day));
  final String harvestDate = formatter.format(futureDate);

  CollectionReference cr =
      db.collection('planting').doc(uid).collection('month');

  String name = obj['plantName'];
  name = name.toLowerCase();

  Map<String, dynamic> data = {
    "name": name,
    "noOfPlants": obj['plantNumber'],
    "date": formatted,
    "estimatedHarvest": obj['plantEstimated'],
    "monthEN": months[dt.month-1],
    "month": dt.month,
    "year": dt.year,
    "day": dt.day,
    "week": dt.weekday,
    "harvestDate": harvestDate,
    "harvested": false,
    "harvestMonth": futureDate.month,
    "harvestDay": futureDate.day,
    "harvestYear": futureDate.year,
  };

  cr.doc().set(data);
}
