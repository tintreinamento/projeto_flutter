import 'package:flutter/material.dart';

class TextComponente extends StatelessWidget {
  final String texto;
  final double fontSize;
  final FontWeight fontWeight;

  const TextComponente(
      {Key? key,
      required this.texto,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.texto,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: this.fontWeight,
          fontStyle: FontStyle.normal,
          fontSize: this.fontSize),
    );
  }
}
