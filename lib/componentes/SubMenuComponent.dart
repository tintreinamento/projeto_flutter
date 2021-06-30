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
<<<<<<< HEAD
=======
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 48.0,
>>>>>>> 5c8ebd9a336cd3ff34117d5f285f6a181d8b0626
      color: colorVermelho,
      padding: paddingPadrao,
      child: Row(
        children: [
<<<<<<< HEAD
=======
          TextComponent(label: widget.titulo, cor: colorBranco, tamanho: 17.0),
>>>>>>> 5c8ebd9a336cd3ff34117d5f285f6a181d8b0626
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
