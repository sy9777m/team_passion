import 'package:apple_sign_in/apple_id_request.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppleSignInModule {
  final Firestore _fireStore = Firestore.instance;

  Future<void> signInWithApple() async {
    final AuthorizationResult _result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (_result.status) {
      case AuthorizationStatus.authorized:
        try {
          final AppleIdCredential appleIdCredential = _result.credential;

          OAuthProvider oAuthProvider = OAuthProvider(providerId: "apple.com");
          final AuthCredential credential = oAuthProvider.getCredential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken),
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode),
          );

          final AuthResult _res =
              await FirebaseAuth.instance.signInWithCredential(credential);

          FirebaseAuth.instance.currentUser().then((val) async {
            UserUpdateInfo updateUser = UserUpdateInfo();
            updateUser.displayName =
                "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";

            await val.updateProfile(updateUser);
          });

          final FirebaseUser _user = _res.user;

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
        } catch (e) {
          print(e);
        }
        break;
      case AuthorizationStatus.error:
        break;
      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
  }
}
