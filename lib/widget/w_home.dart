import 'package:flutter/material.dart';

class MyGoalCard extends StatelessWidget {
  const MyGoalCard({
    @required this.title,
    @required this.deadLine,
    this.color,
    this.onPressed,
    @required this.icon,
    this.onDismissed,
    Key key,
  }) : super(key: key);

  final String title;
  final String deadLine;
  final Function onPressed;
  final Color color;
  final Icon icon;
  final Function onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      onDismissed: onDismissed,
      key: key,
      child: Card(
        color: color,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  deadLine,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: icon,
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
