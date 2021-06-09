import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/componentes/textformfield.dart';

Widget inputComponente(String label,
    TextEditingController textEditingController, Function handleSubmitted) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textComponente(label),
      textFormFieldComponente(textEditingController, handleSubmitted),
      Divider(),
    ],
  );
}
