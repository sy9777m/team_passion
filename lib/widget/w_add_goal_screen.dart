import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    this.hintText,
    this.labelText,
    Key key,
  }) : super(key: key);

  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: 15.0,
          ),
          hintStyle: TextStyle(
            fontSize: 15.0,
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

class TextInputArea extends StatelessWidget {
  const TextInputArea({
    this.hintText,
    this.labelText,
    Key key,
  }) : super(key: key);

  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
          labelStyle: TextStyle(
            fontSize: 15.0,
          ),
          hintStyle: TextStyle(
            fontSize: 15.0,
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  final Text title;
  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        elevation: 3.0,
        child: ListTile(
          onTap: onTap,
          leading: icon,
          title: title,
        ),
      ),
    );
  }
}

class PickDeadlineButton extends StatefulWidget {
  const PickDeadlineButton({
    Key key,
  }) : super(key: key);

  @override
  _PickDeadlineButtonState createState() => _PickDeadlineButtonState();
}

class _PickDeadlineButtonState extends State<PickDeadlineButton> {
  bool setDeadline = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireBaseModule>(builder: (context, firebaseModule, child) {
      return CardWidget(
        title: Text(
            setDeadline ? firebaseModule.getDeadline.toString() : '마감일 설정'),
        icon: Icon(FontAwesomeIcons.calendarAlt),
        onTap: () async {
          DateTime _deadline = await showDatePicker(
              context: context,
              initialDate: firebaseModule.getDeadline,
              firstDate: firebaseModule.getDeadline,
              lastDate: DateTime(2100));
          firebaseModule.setDeadline(_deadline);
          setState(() {
            setDeadline = true;
          });
        },
      );
    });
  }
}
