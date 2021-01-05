import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/farm/models/Planting.dart';

void addData(Map<String, dynamic> obj) {
  String month = DateTime.now().month.toString().toLowerCase();

  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference cr =
      db.collection("Planting").doc(month).collection("Activity");

  Map<String, dynamic> data = {
    "name": obj['plantName'],
    "noOfPlants": obj['plantNumber'],
    "date": obj['date'],
    "estimatedHarvest": obj['plantEstimated'],
  };

  cr.doc().set(data);
}
