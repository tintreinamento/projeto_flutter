import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/componentes/textformfield.dart';

Widget inputComponente(
    String label, TextEditingController textEditingController) {
  return Column(
    children: [
      textComponente(label),
      textFormFieldComponente(textEditingController)
    ],
  );
}
