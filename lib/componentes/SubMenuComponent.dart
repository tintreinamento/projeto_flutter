import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class SubMenuComponent extends StatefulWidget {
  String titulo;
  String tituloPrimeiraRota;
  var primeiraRota;
  String tituloSegundaRota;
  var segundaRota;

  SubMenuComponent(
      {Key? key,
      required this.titulo,
      required this.tituloPrimeiraRota,
      required this.primeiraRota,
      required this.tituloSegundaRota,
      required this.segundaRota})
      : super(key: key);

  @override
  _SubMenuComponentState createState() => _SubMenuComponentState();
}

class _SubMenuComponentState extends State<SubMenuComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 8),
      height: 48.0,
      color: colorVermelho,
      child: Row(
        children: [
          TextComponent(
            fontWeight: FontWeight.bold,
            label: widget.titulo,
            cor: colorBranco,
            fontSize: 14,
          ),
          Flexible(
              child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(widget.primeiraRota);
                },
                child: TextComponent(
                  fontWeight: FontWeight.bold,
                  label: widget.tituloPrimeiraRota,
                  cor: colorBranco,
                )),
          )),
          Flexible(
              child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(widget.segundaRota);
                },
                child: TextComponent(
                  fontWeight: FontWeight.bold,
                  label: widget.tituloSegundaRota,
                  cor: colorBranco,
                )),
          )),
        ],
      ),
    );
  }
}
