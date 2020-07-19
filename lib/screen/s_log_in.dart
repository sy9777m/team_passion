import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/screen/s_home.dart';

class LogInPage extends StatelessWidget {
  static String id = './log_in_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Center(
              child: Text(
                'Team Passion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Center(
            child: Consumer<FirebaseModule>(
                builder: (context, firebaseModule, child) {
              return Column(
                children: [
                  GoogleSignInButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: CupertinoAlertDialog(
                              title: Text('Loading'),
                              content: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      );
                      await firebaseModule.signInWithGoogle();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, Home.id);
                    },
                  ),
                  AppleSignInButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: CupertinoAlertDialog(
                              title: Text('Loading'),
                              content: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      );
                      await firebaseModule.signInWithApple();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, Home.id);
                    },
                    style: AppleButtonStyle.black,
                  ),
                  FacebookSignInButton(),
                  MicrosoftSignInButton(
                    darkMode: true,
                  ),
                  TwitterSignInButton(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
