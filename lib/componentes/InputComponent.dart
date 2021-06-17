import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/componentes/textformfield.dart';

class InputComponent extends StatefulWidget {
  var label;
  var controller;
  var handleOnChange;

  InputComponent({Key? key, this.label, this.controller, this.handleOnChange})
      : super(key: key);

  @override
  _InputComponentState createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: TextLabel(
            label: widget.label,
          )),
          Expanded(
              child: TextFieldFormComponent(
            controller: widget.controller,
            handleOnchange: widget.handleOnChange,
          ))
        ],
      ),
    );
  }
}
