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
          backgroundColor: Color.fromRGBO(0, 94, 181, 1),
          actions: [],
          flexibleSpace: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.green,
                    padding: EdgeInsets.only(right: 6, bottom: 5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      this.titulo,
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
                Flexible(
                    child: Container(
                  height: 27,
                  color: Color.fromRGBO(206, 5, 5, 1),
                  child: Row(
                    children: [
                      Text('Pedido venda ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      Text('|',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      Text('Cadastro ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      Text('|',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      Text('Consulta ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                      Text('|',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          )),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(300.0));
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
