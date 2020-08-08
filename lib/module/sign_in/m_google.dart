import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInModule {
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
}
