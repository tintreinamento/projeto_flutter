import 'package:flutter/material.dart';
import 'TextComponent.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String titulo = 'Sistema de Gestão de Vendas';
  final AppBar appBar = new AppBar();

  /// you can add more fields that meet your needs

  AppBarComponent({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 94, 181, 1),
          actions: [],
          flexibleSpace: Container(
            height: 100.0,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 73.0,
                    padding: EdgeInsets.only(top: 30, right: 6, bottom: 5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Sistema de Gestão de Vendas',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(73.0));
  }
}
