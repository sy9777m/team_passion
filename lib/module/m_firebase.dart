import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseModule extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _fireStore = Firestore.instance;

  FirebaseUser _currentUser;

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

    QuerySnapshot _documentQuery =
        await _fireStore.collection('users').getDocuments();

    List<String> _documentIDList = [];
    _documentQuery.documents.forEach((element) {
      _documentIDList.add(element.documentID);
    });

    if (!_documentIDList.contains(_user.uid)) {
      await _fireStore.collection('users').document(_user.uid).setData({
        'id': _user.uid,
        'name': _user.displayName,
        'email': _user.email,
        'imageUrl': _user.photoUrl,
      });
    } else {
      await _fireStore
          .collection('users')
          .document(_user.uid)
          .setData({'lastLogin': DateTime.now()}, merge: true);
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }

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
