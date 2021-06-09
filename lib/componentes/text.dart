import 'package:flutter/cupertino.dart';

Widget textComponente(String label) {
  return Text(
    label,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
  );
}
