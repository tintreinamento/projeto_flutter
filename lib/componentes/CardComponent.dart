import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class CardComponent extends StatefulWidget {
  String? label;
  var content;

  CardComponent({Key? key, this.label, this.content}) : super(key: key);

  @override
  _CardComponentState createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: 320.0,
          padding: EdgeInsets.only(left: 20, top: 20, right: 20),
          decoration: boxDecorationComponent,
          child: Center(
            child: widget.content,
          ),
        ),
        Positioned(
            top: -5,
            left: 30,
            child: Container(
              color: colorBranco,
              child: TextComponent(
                label: widget.label!.toUpperCase(),
              ),
            )),
      ],
    );
  }
}
