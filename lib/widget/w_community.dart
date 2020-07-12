import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtherUserCard extends StatelessWidget {
  const OtherUserCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              child: Text('User Image'),
              radius: 50.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                Text(
                  'Day since start',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.thumbsUp),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
