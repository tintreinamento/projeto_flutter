import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class FormComponent extends StatefulWidget {
  String? label;
  var content;

  FormComponent({Key? key, this.label, this.content}) : super(key: key);

  @override
  _FormComponentState createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: boxDecorationComponent,
            child: widget.content,
          ),
          Positioned(
              top: 15,
              left: 30,
              child: Container(
                color: colorBranco,
                child: TextComponent(
                  label: widget.label!.toUpperCase(),
                ),
              )),
        ],
      ),
    );
  }
}
