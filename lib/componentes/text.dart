import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class TextLabel extends StatefulWidget {
  var label;
  Color? cor = colorPreto;
  double? tamanho = fontTamanho;

  TextLabel({Key? key, this.label, this.tamanho, this.cor}) : super(key: key);

  @override
  _TextLabelState createState() => _TextLabelState();
}

class _TextLabelState extends State<TextLabel> {
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
