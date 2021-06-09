import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget textFormFieldComponente(TextEditingController textEditingController) {
  return TextFormField(
    style: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 24,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(186, 171, 171, 1))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(186, 171, 171, 1))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Digite seu usuário';
      }
      return null;
    },
  );
}
