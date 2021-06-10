import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/componentes/textformfield.dart';
import 'package:flutter/services.dart';

class InputComponente extends StatelessWidget {
  String label;
  TextInputFormatter maskFormatter;
  TextInputFormatter filter;
  TextEditingController textEditingController;
  Function handleSubmitted;

  InputComponente(
      {Key? key,
      required this.label,
      required this.maskFormatter,
      required this.filter,
      required this.textEditingController,
      required this.handleSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponente(label: label),
        TextFormFieldComponente(
            maskFormatter: maskFormatter,
            filter: filter,
            textEditingController: textEditingController,
            handleSubmitted: handleSubmitted),
        Divider(),
      ],
    );
  }
}
