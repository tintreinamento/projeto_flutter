import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextComponent extends StatefulWidget {
  var label;
  Color? cor = colorPreto;
  double? tamanho = fontTamanho;
  double? height;
  FontWeight? fontWeight;
  double? fontSize;

  TextComponent(
      {Key? key,
      this.label,
      this.tamanho,
      this.cor,
      this.height,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  _TextComponentState createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    if (widget.fontSize == null) {
      widget.fontSize = 12;
    }

    return Text(
        widget.label,
        overflow: TextOverflow.fade,
        maxLines: 3,
        style: TextStyle(
            height: widget.height,
            fontFamily: fontFamilia,
            fontWeight: widget.fontWeight,
            fontSize: widget.fontSize! * mediaQuery.textScaleFactor,
            fontStyle: fontEstilo,
            color: widget.cor),
      );
  }
}
