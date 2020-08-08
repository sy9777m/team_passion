import 'package:cloud_firestore/cloud_firestore.dart';

class TwitterSignInModule {
  final Firestore _fireStore = Firestore.instance;

  Future<void> signInWithTwitter() async {
    QuerySnapshot _documentQuery =
        await _fireStore.collection('users').getDocuments();

    List<String> _documentIDList = [];
    _documentQuery.documents.forEach((element) {
      _documentIDList.add(element.documentID);
    });
//
//    if (!_documentIDList.contains(_user.uid)) {
//      await _fireStore.collection('users').document(_user.uid).setData({
//        'id': _user.uid,
//        'name': _user.displayName,
//        'email': _user.email,
//        'imageUrl': _user.photoUrl,
//      });
//    } else {
//      await _fireStore
//          .collection('users')
//          .document(_user.uid)
//          .setData({'lastLogin': DateTime.now()}, merge: true);
//    }
  }
}
