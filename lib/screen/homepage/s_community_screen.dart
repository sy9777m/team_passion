import 'package:flutter/material.dart';
import 'package:team_passion/widget/w_community_screen.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        Center(
          child: Text(
            '친구 응원하기',
            style: TextStyle(
              fontSize: 35.0,
            ),
          ),
        ),
        OtherUserCard(),
      ],
    );
  }
}
