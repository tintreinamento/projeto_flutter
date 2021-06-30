import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class MolduraComponent extends StatelessWidget {
  String? label;
  var content;
  MolduraComponent({Key? key, this.label, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: boxDecorationComponent,
            child: content,
          ),
          Positioned(
              top: 15,
              left: 30,
              child: Container(
                color: colorBranco,
                child: TextComponent(
                  label: label!.toUpperCase(),
                ),
              )),
        ],
      ),
    );
  }
}
