import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

import 'package:flutter/services.dart';

class InputComponent extends StatefulWidget {
  var label;
  List<TextInputFormatter>? inputFormatter;
  TextEditingController? controller;
  Function? onChange;
  Function? onFieldSubmitted;
  FormFieldValidator<String>? validator;
  bool? obscureText;

  InputComponent(
      {Key? key,
      this.label,
      this.inputFormatter,
      this.controller,
      this.onChange,
      this.onFieldSubmitted,
      this.validator,
      this.obscureText})
      : super(key: key);

  @override
  _InputComponentState createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: mediaQuery.size.width * 0.15,
            child: TextComponent(
              label: widget.label,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextFormFieldComponent(
              obscureText: widget.obscureText,
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
