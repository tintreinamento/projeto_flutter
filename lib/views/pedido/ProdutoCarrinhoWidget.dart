import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';

class ProdutoCarrinhoWidget extends StatefulWidget {
  final bool? active;
  final Function? onTap;

  ProdutoCarrinhoWidget({Key? key, this.active, this.onTap}) : super(key: key);

  @override
  _ProdutoCarrinhoWidgetState createState() => _ProdutoCarrinhoWidgetState();
}

class _ProdutoCarrinhoWidgetState extends State<ProdutoCarrinhoWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        child: Container(
          decoration: BoxDecoration(
              color: colorCinza,
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(16)),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.70,
          padding: EdgeInsets.all(10),
          child: Text('text'),
        ),
        curve: Curves.decelerate,
        bottom: widget.active! ? 5 : -600,
        duration: Duration(milliseconds: 500));
  }
}
