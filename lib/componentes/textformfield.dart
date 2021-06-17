import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextFieldFormComponent extends StatefulWidget {
  TextEditingController? controller;

  Function? handleOnchange;

  TextFieldFormComponent({Key? key, this.controller, this.handleOnchange})
      : super(key: key);

  @override
  _TextFieldFormComponentState createState() => _TextFieldFormComponentState();
}

class _TextFieldFormComponentState extends State<TextFieldFormComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      child: TextField(
        controller: widget.controller,
        decoration: inputDecorationComponente,
        onChanged: (text) {
          widget.handleOnchange!();
        },
      ),
    );
  }
}
