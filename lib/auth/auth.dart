// import 'package:dronaidadmin/database/db.dart';
import 'package:accelth/models/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? getMyUser() {
    return convertToMyUser(_auth.currentUser);
  }
  User? getFirebaseUser(){
    return _auth.currentUser;
  }

  MyUser? convertToMyUser(User? userr) {
    if (userr == null) {
      return null;
    } else {
      MyUser temp = MyUser(
        uid: userr.uid,
      );
      return temp;
    }
  }

  Stream<MyUser?> get userChanges {
    return _auth.authStateChanges().map((event) => convertToMyUser(event));
  }

  Future<MyUser?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User userr = result.user!;
      // await userr.updateDisplayName(name);
      return convertToMyUser(userr);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User userr = result.user!;
      // await hbtData.getDatabase();
      return convertToMyUser(userr);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }
}
