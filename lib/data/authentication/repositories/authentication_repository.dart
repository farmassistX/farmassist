import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<AppUser> get appUser {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AppUser.empty
          : AppUser(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              name: firebaseUser.displayName,
              photo: firebaseUser.photoURL,
            );
    });
  }

  Future<void> signUp({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    assert(name != null && email != null && password != null);
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user;
      await user.updateProfile(displayName: name);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'id': user.uid,
        'email': email,
        'displayName': name,
      });
      await FirebaseFirestore.instance.collection('planting').doc(user.uid).set({
        'id': user.uid,
      });
      await FirebaseFirestore.instance.collection('harvesting').doc(user.uid).set({
        'id': user.uid,
      });
      await FirebaseFirestore.instance.collection('planting').doc(user.uid).collection("month").doc().set({
        'month': -99,
      });
      await FirebaseFirestore.instance.collection('harvesting').doc(user.uid).collection("month").doc().set({
        'month': -99,
      });
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
