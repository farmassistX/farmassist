import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

void harvestData(Map<String, dynamic> obj){
  User user = auth.currentUser;
  final uid = user.uid;

  DateTime harvestDt = obj['harvestDate'];

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String harvestDate = formatter.format(harvestDt);


  CollectionReference cr =
  db.collection("harvesting").doc(uid).collection('month');

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

void updatePlanting(String id){
  User user = auth.currentUser;
  final uid = user.uid;

  CollectionReference cr =
  db.collection("planting").doc(uid).collection('month');
  
  cr.doc(id).update({
    "harvested": true
  }).then((value) => print('success'));
}