import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

class InputComponent extends StatefulWidget {
  var label;
  TextEditingController? controller;
  Function? onChange;
  ValueChanged<String>? onFieldSubmitted;
  Function? validator;

  InputComponent(
      {Key? key,
      this.label,
      this.controller,
      this.onChange,
      this.onFieldSubmitted,
      this.validator})
      : super(key: key);

  @override
  _InputComponentState createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: TextComponent(
            label: widget.label,
          )),
          Flexible(
              child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextFormFieldComponent(
              controller: widget.controller,
              onChange: widget.onChange,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
            ),
          ))
        ],
      ),
    );
  }
}
