import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextFormFieldComponent extends StatefulWidget {
  TextEditingController? controller;
  Function? onChange;
  ValueChanged<String>? onFieldSubmitted;
  Function? validator;

  TextFormFieldComponent(
      {Key? key,
      this.controller,
      this.onFieldSubmitted,
      this.onChange,
      this.validator})
      : super(key: key);

  @override
  _TextFormFieldComponentState createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: TextFormField(
        controller: widget.controller,
        decoration: inputDecorationComponent,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: (value) {
          widget.onChange!();
        },
        validator: (value) {
          widget.validator!();
        },
      ),
    );
  }
}
