import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class FireBaseModule extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _fireStore = Firestore.instance;

//  login, user data
  FirebaseUser _currentUser;
  Map<String, dynamic> _userDocument;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken,
    );

    final AuthResult _authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser _user = _authResult.user;

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    _currentUser = await _auth.currentUser();
    assert(_user.uid == _currentUser.uid);

    await _fireStore.collection('users').document(_user.uid).setData({
      'id': _user.uid,
      'name': _user.displayName,
      'email': _user.email,
      'imageUrl': _user.photoUrl,
    });
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<void> getUserData() async {
    final DocumentSnapshot _userDocumentSnapshot =
        await _fireStore.collection('users').document(_currentUser.uid).get();
    _userDocument = _userDocumentSnapshot.data;
  }

  String get getUserName => _userDocument['name'];
  String get getUserEmail => _userDocument['email'];
  String get getUserImageUrl => _userDocument['imageUrl'];

//  goal data

  Future<void> createGoal(String title, String memo, DateTime deadLine) async {
    await _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .collection('goals')
        .document()
        .setData({
      'title': title,
      'memo': memo,
      'deadLine': deadLine,
    });
  }

  Future<void> editGoal(String fieldKey, String fieldValue) async {
    await _fireStore
        .collection('goals')
        .document(_currentUser.uid)
        .updateData({fieldKey: fieldValue});
  }

  Future<void> loadGoals() async {}

  Future<void> deleteGoal() async {
    await _fireStore.collection('goals').document(_currentUser.uid).setData({});
  }
}
