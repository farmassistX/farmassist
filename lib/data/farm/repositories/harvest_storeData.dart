import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

User user = auth.currentUser;
final uid = user.uid;

void harvestData(Map<String, dynamic> obj) {
  var month;

  DateTime harvestDt = obj['harvestDate'];
  print(harvestDt.month);

  if (harvestDt.month == 1) {
    month = "January";
  } else {
    month = "February";
  }

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String harvestDate = formatter.format(harvestDt);

  CollectionReference cr =
      db.collection("Harvesting").doc(uid).collection(month);

  Map<String, dynamic> data = {
    "name": obj['plantName'],
    "noOfPlants": obj['plantNumber'],
    "date": obj['plantDate'],
    "estimatedHarvest": obj['plantEstimated'],
    "month": harvestDt.month,
    "year": harvestDt.year,
    "day": harvestDt.day,
    "week": harvestDt.weekday,
    "harvestQuantity": obj['harvestQuantity'],
    "harvestDate": harvestDate,
  };

  cr.doc().set(data);
}

void updatePlanting(int monthInt, String id) {
  var month;

  if (monthInt == 1) {
    month = "January";
  } else {
    month = "February";
  }

  CollectionReference cr = db.collection("Planting").doc(uid).collection(month);

  cr.doc(id).update({"harvested": true}).then((value) => print('success'));
}
