import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextFormFieldComponent extends StatefulWidget {
  List<TextInputFormatter>? inputFormatter;
  TextEditingController? controller;
  Function? onChange;
  Function? onFieldSubmitted;
  FormFieldValidator<String>? validator;

  TextFormFieldComponent(
      {Key? key,
      this.inputFormatter,
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
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      controller: widget.controller,
      decoration: inputDecorationComponent,
      onFieldSubmitted: (value) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(value);
        }
      },
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      validator: widget.validator,
    );
  }
}
