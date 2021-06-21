import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:flutter/services.dart';

class InputComponent extends StatefulWidget {
  var label;
  List<TextInputFormatter>? inputFormatter;
  TextEditingController? controller;
  Function? onChange;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldValidator<String>? validator;

  InputComponent(
      {Key? key,
      this.label,
      this.inputFormatter,
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
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 260.0, minHeight: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextComponent(
            label: widget.label,
          ),
          Expanded(
            child: TextFormFieldComponent(
              inputFormatter: widget.inputFormatter,
              controller: widget.controller,
              onChange: widget.onChange,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
            ),
          )
        ],
      ),
    );
  }
}
