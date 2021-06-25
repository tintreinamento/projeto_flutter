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
      color: colorVermelho,
      padding: paddingPadrao,
      child: Row(
        children: [
          Flexible(
            child: TextComponent(
                label: widget.titulo, cor: colorBranco, tamanho: 18.0),
          ),
          Expanded(
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, widget.primeiraRota);
                },
                child: TextComponent(
                  label: widget.tituloPrimeiraRota,
                  cor: colorBranco,
                )),
          ),
          Expanded(
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(widget.segundaRota);
                },
                child: TextComponent(
                  label: widget.tituloSegundaRota,
                  cor: colorBranco,
                )),
          ),
        ],
      ),
    );
  }
}
