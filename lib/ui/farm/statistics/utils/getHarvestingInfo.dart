import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

Map<int, String> _keys;
Map<String, int> _keys2;

Map<int, List> getHarvesting() {
  User user = auth.currentUser;
  final uid = user.uid;

  Map<int, List> _harvesting = new Map();
  _keys = new Map();
  _keys2 = new Map();
  int index = 0;

  db.collection('harvesting').doc(uid).collection('month')
  .get()
  .then((value) => value.docs.forEach((element) {
   if(element.get('month')==-99){
     print('');
   }else {
     if (_keys2.containsKey(element.get('name'))) {
       String name = element.get('name');
       int yield = int.parse(element.get('harvestQuantity'));
       int index = _keys2[name];
       List list = _harvesting[index];
       int oldYield = list[0]['quantity'];
       list = [{
         'name': name,
         'quantity': yield+oldYield,
       }];
       _harvesting.update(index, (value) => list);
     } else {
       String plantName = element.get('name');
       int yield = int.parse(element.get('harvestQuantity'));
       _harvesting[index] = [{
         'name': element.get('name'),
         'quantity': yield
       }];
       _keys2[plantName]=index;
       _keys[index]=plantName;
       index++;
     }
   }
  }));
  return _harvesting;
}

Map<int, String> getKeys(){
  return _keys;
}
