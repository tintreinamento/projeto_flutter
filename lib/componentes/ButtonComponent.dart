import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

class ButtonComponent extends StatefulWidget {
  var label;
  var onPressed;

  ButtonComponent({Key? key, this.label, this.onPressed}) : super(key: key);

  @override
  _ButtonComponentState createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 30,
        margin: EdgeInsets.only(top: 18, bottom: 13),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(0, 94, 181, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ))),
          onPressed: () {
            widget.onPressed();
          },
          child: TextComponent(
            fontWeight: FontWeight.bold,
            tamanho: 18,
            label: widget.label,
          ),
        ));
  }
}
