import 'package:flutter/material.dart';

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
