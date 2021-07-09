import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

class ButtonComponent extends StatefulWidget {
  var label;
  var onPressed;
  double width;
  double height;
  double fontSize;

  ButtonComponent(
      {Key? key,
      this.label,
      this.onPressed,
      this.width: 220,
      this.height: 30,
      this.fontSize: 18})
      : super(key: key);

  @override
  _ButtonComponentState createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
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
              tamanho: widget.fontSize,
              label: widget.label),
        ));
  }
}
