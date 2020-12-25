import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/farm/models/Planting.dart';

void addData(Planting obj) {
  String month = DateTime.now().month.toString().toLowerCase();

  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference cr =
      db.collection("Planting").doc(month).collection("Activity");

  Map<String, dynamic> data = {
    "name": obj.name,
    "noOfPlants": obj.noOfPlants,
    "date": obj.date,
    "estimatedHarvest": obj.estimatedHarvest,
    "location": obj.location,
    "fertilizers": obj.fertilizers,
    "_seedsUsed": obj.seedsUsed,
  };

  cr.doc().set(data);
}
