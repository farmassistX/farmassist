import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/farm/models/Planting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


void addData(Map<String, dynamic> obj) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User user = auth.currentUser;
  final uid = user.uid;
  var month;

  DateTime dt = obj['plantDate'];
  print(dt.month);

  if(dt.month==1){
    month="January";
  }
  else{
    month="February";
  }

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(dt);

  CollectionReference cr =
      db.collection("Planting").doc(uid).collection(month);

  Map<String, dynamic> data = {
    "name": obj['plantName'],
    "noOfPlants": obj['plantNumber'],
    "date": formatted,
    "estimatedHarvest": obj['plantEstimated'],
    "month": dt.month,
    "year": dt.year,
    "day": dt.day,
    "week": dt.weekday,
  };

  cr.doc().set(data);
}
