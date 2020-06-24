import 'package:flutter/material.dart';
import 'package:team_passion/widget/w_home_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [MyGoalCard()],
        ),
      ),
    );
  }
}
