import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyGoalCard extends StatelessWidget {
  const MyGoalCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Goal Title',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Deadline',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
