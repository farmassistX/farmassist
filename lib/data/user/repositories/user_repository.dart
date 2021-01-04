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
  static String _uid;
  DocumentReference _userDoc;

  User get currentUser => _currentUser;
  static String get uid => _uid;

  Future<void> saveToken(String token) async {
    await _userDoc.update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  Future<void> update(AppUser appUser) async {
    await _userDoc.update(appUser.toMap());
  }

  Future<void> delete() => _userDoc.delete();
}
