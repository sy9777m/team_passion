import 'package:flutter/material.dart';
import 'package:team_passion/widget/w_my_screen.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyCard(),
            Divider(),
            GoalTrackTable(),
            Divider(),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}
