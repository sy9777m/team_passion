import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    this.hintText,
    this.labelText,
    this.onChange,
    this.onSubmitted,
    Key key,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Function onChange;
  final Function onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireBaseModule>(builder: (context, firebaseModule, child) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          onChanged: onChange,
          validator: (value) {
            if (value.isEmpty) {
              return '타이틀을 입력해주세요.';
            } else
              return null;
          },
          keyboardType: TextInputType.text,
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
    });
  }
}

class TextInputArea extends StatelessWidget {
  const TextInputArea({
    this.onSubmitted,
    this.onChange,
    this.hintText,
    this.labelText,
    Key key,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Function onChange;
  final Function onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        onChanged: onChange,
        onSubmitted: onSubmitted,
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

class CreateGoalButton extends StatelessWidget {
  const CreateGoalButton({
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireBaseModule>(builder: (context, firebaseModule, child) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        width: double.maxFinite,
        child: RaisedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '목표 생성',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }
}
