import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_passion/module/sign_in/m_apple.dart';
import 'package:team_passion/module/sign_in/m_google.dart';

class FirebaseModule extends ChangeNotifier
    with GoogleSignInModule, AppleSignInModule {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  FirebaseUser _currentUser;

//  Apple sign in
  final GoogleSignInModule _googleSignInModule = GoogleSignInModule();
  final AppleSignInModule _appleSignInModule = AppleSignInModule();

  Future<void> signInWithApple() async {
    await _appleSignInModule.signInWithApple();
  }

//  Google Sign in
  Future<void> signInWithGoogle() async {
    await _googleSignInModule.signInWithGoogle();

    _currentUser = await _auth.currentUser();
  }

  Future<void> signOutGoogle() async {
    await _googleSignInModule.signOutGoogle();
  }

// Facebook Sign in
  Future<void> signInWithFacebook() async {}

  Map<String, dynamic> _userDocument;

  Future<void> getUserData() async {
    final DocumentSnapshot _userDocumentSnapshot =
        await _fireStore.collection('users').document(_currentUser.uid).get();
    _userDocument = _userDocumentSnapshot.data;
  }

  Stream<DocumentSnapshot> getUserSnapshot() {
    return _fireStore
        .collection('users')
        .document(_currentUser.uid)
        .snapshots();
  }

  String get getUserName => _userDocument['name'];
  String get getUserEmail => _userDocument['email'];
  String get getUserImageUrl => _userDocument['imageUrl'];

//  goal data

  String _title = '';
  DateTime _deadline = DateTime.now();

  void setTitle(String title) {
    _title = title;
  }

  void setDeadline(DateTime deadline) {
    _deadline = deadline;
  }

  Future<void> createGoal() async {
    DocumentReference _goalReference = _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .document();

    await _goalReference.setData({
      'goalId': _goalReference.documentID,
      'title': _title,
      'deadLine': _deadline,
      'isDone': false,
      'inTime': true,
    });
  }

  Stream<QuerySnapshot> loadGoalsSnapshot() {
    return _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .snapshots();
  }

  Future<void> deleteGoal(String goalId) async {
    await _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .document(goalId)
        .delete();
  }

  Future<void> doneGoal(String goalId) async {
    await _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .document(goalId)
        .setData({
      'isDone': true,
    }, merge: true);
  }

  Future<void> cancelDone(String goalId) async {
    await _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .document(goalId)
        .setData({
      'isDone': false,
    }, merge: true);
  }
}
