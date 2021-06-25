import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class InputComponent extends StatefulWidget {
  var label;
  List<TextInputFormatter>? inputFormatter;
  TextEditingController? controller;
  Function? onChange;
  Function? onFieldSubmitted;
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
    return Container(
      padding: paddingPadrao,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: TextComponent(
              label: widget.label,
            ),
          ),
          Expanded(
            flex: 4,
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
