import 'package:apple_sign_in/apple_id_request.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppleSignInModule {
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

  Future<void> signOutWithApple() async {}
}
