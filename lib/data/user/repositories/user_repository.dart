import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository() {
    _currentUser = FirebaseAuth.instance.currentUser;
    _uid = _currentUser.uid;
    _userDoc = FirebaseFirestore.instance.collection('users').doc(_uid);
  }

  User _currentUser;
  String _uid;
  DocumentReference _userDoc;

  User get currentUser => FirebaseAuth.instance.currentUser;
  String get uid => FirebaseAuth.instance.currentUser.uid;
  String get email => FirebaseAuth.instance.currentUser.email;
  String get displayName => FirebaseAuth.instance.currentUser.displayName;

  Future<void> saveToken(String token) async {
    await _userDoc.set({
      'tokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
    // Quick and dirty solution, it just works.
    Future.delayed(Duration(seconds: 1), () {
      _userDoc.update({
        'tokens': FieldValue.arrayUnion([token]),
      });
    });
  }

  Future<void> deleteToken(String token) {
    return _userDoc.update({
      'tokens': FieldValue.arrayRemove([token]),
    });
  }

  Future<void> update(AppUser appUser) {
    return _userDoc.update(appUser.toMap());
  }

  Future<void> delete() => _userDoc.delete();
}
