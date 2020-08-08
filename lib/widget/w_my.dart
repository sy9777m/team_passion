import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/screen/s_log_in.dart';

class GoalTrackingDot extends StatelessWidget {
  const GoalTrackingDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.lightGreenAccent,
      ),
      width: 15.0,
      height: 15.0,
    );
  }
}

class GoalTrackTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int _width = (MediaQuery.of(context).size.width / 15).floor();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: _width,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        children: [
          GoalTrackingDot(),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseModule>(
      builder: (context, firebaseModule, child) {
        return RaisedButton(
          elevation: 7.0,
          onPressed: () async {
            firebaseModule.signOut();
            Navigator.pushReplacementNamed(context, LogInPage.id);
          },
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.pencilAlt,
                size: 20.0,
              ),
              onPressed: () {},
            ),
            Consumer<FirebaseModule>(builder: (context, firebaseModule, child) {
              return FutureBuilder<void>(
                  future: firebaseModule.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.maxFinite,
                          ),
                          Card(
                            elevation: 5.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(firebaseModule.getUserImageUrl),
                              radius: 40.0,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Text(
                            firebaseModule.getUserName,
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                          Text(
                            'Day since start',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }),
          ],
        ),
      ),
    );
  }
}
