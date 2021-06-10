import 'package:flutter/material.dart';
import './text.dart';

class AppBarComponente extends StatelessWidget implements PreferredSizeWidget {
  final String titulo = 'Sistema de Gestão de Vendas';
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const AppBarComponente({Key? key, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          centerTitle: false,
          title: TextComponente(label: this.titulo),
          backgroundColor: Color.fromRGBO(0, 94, 181, 1),
          actions: [
            Container(
              width: 100,
            )
          ],
        ),
        preferredSize: Size.fromHeight(73.0));
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
