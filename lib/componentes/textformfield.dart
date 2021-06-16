import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class TextFormFieldComponente extends StatelessWidget {
  TextInputFormatter maskFormatter;
  TextInputFormatter filter;
  TextEditingController textEditingController;
  Function handleSubmitted;

  TextFormFieldComponente(
      {Key? key,
      required this.maskFormatter,
      required this.filter,
      required this.textEditingController,
      required this.handleSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        filter,
        maskFormatter,
      ],
      controller: textEditingController,
      onSubmitted: (text) {
        handleSubmitted();
      },
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
    );
  }
}
