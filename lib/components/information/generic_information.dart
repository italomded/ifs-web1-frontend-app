import 'package:flutter/material.dart';

class GenericInformation extends StatelessWidget {
  final IconData icon;
  final String text;
  final String titleText;

  const GenericInformation(
      {Key? key,
      required this.icon,
      required this.text,
      required this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Icon(icon),
        ),
        Flexible(
          flex: 2,
          child: Text("$titleText: $text"),
        ),
      ],
    );
  }
}
