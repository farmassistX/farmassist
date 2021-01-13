import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;



Map<DateTime, List> getHarvestEvents(){
  User user = auth.currentUser;
  final uid = user.uid;
  Map<DateTime, List> _events = new Map();

  db.collection('planting').doc(uid).collection('month')
      .get()
      .then((value) => value.docs.forEach((element) {
        if(element.get('month')==-99){
          print('');
        }
        else {
          var plantName =element.get('name');
          if(_events.containsKey(DateTime(element.get('harvestYear'), element.get('harvestMonth'), element.get('harvestDay')))){
            var list = {
              'name': 'Harvest $plantName',
              'isDone': element.get('harvested'),
            };

            _events[DateTime(element.get('harvestYear'), element.get('harvestMonth'), element.get('harvestDay'))].add(list);
          } else{
              _events[DateTime(element.get('harvestYear'), element.get('harvestMonth'), element.get('harvestDay'))] =
              [
                {
                  'name': 'Harvest $plantName',
                  'isDone': element.get('harvested'),
                }
              ];
            }
          }
  }));
  return _events;
}