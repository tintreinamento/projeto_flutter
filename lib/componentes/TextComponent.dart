import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextComponent extends StatefulWidget {
  var label;
  Color? cor = colorPreto;
  double? tamanho = fontTamanho;

  TextComponent({Key? key, this.label, this.tamanho, this.cor})
      : super(key: key);

  @override
  _TextComponentState createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      style: TextStyle(
          fontFamily: fontFamilia,
          fontWeight: fontLargura,
          fontSize: widget.tamanho,
          fontStyle: fontEstilo,
          color: widget.cor),
    );
  }
}
