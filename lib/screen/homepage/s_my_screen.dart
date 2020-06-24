import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
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
              Consumer<FireBaseModule>(
                  builder: (context, firebaseModule, child) {
                firebaseModule.getUserData();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                    ),
                    Card(
                      elevation: 10.0,
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
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
