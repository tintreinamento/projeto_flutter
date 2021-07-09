import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/services/Auth.dart';
//import 'package:projeto_flutter/views/pedido/pedido.dart';
//import '../views/pedido/pedido.dart';

import 'package:provider/provider.dart';

class DrawerComponent extends StatelessWidget {
  Widget headerMenu(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
        width: 368,
        height: 73,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 368,
                  height: 73,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 93, 180, 1),
                  ))),
          Positioned(
              top: 36,
              left: 13,
              child: Container(
                  width: 338,
                  height: 31,
                  child: Stack(children: <Widget>[
                    Positioned(
                      top: 2,
                      left: -20,
                      child: FlatButton(
                          onPressed: () {
                            //Auth.logout();
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Container(
                              child: Image(
                                  image:
                                      AssetImage('assets/images/return.png')))),
                    ),
                    Positioned(
                        top: 0,
                        left: 38,
                        child: Text(
                          'matheus.oliveira',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                      top: 15,
                      left: 38,
                      child: GestureDetector(
                          onTap: () {
                            //Auth.logout();
                            Navigator.pushNamed(context, '/login');
                          },
                          child: TextComponent(
                            label: 'Sair',
                            cor: colorBranco,
                          )),
                    ),
                    Positioned(
                        top: 1,
                        left: 290,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios, color: Colors.grey),
                        )),
                  ]))),
        ]));
  }

  //Item do menu
  Widget itemMenu(String titulo, BuildContext context, String rota) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              titulo,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, rota);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width * 0.8,
      height: mediaQuery.size.height,
      color: colorBranco,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            color: colorAzul,
            height: mediaQuery.size.height * 0.2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.logout),
                    color: colorBranco,
                    onPressed: () => Navigator.pushNamed(context, '/login')),
                TextComponent(
                  label: Provider.of<AutenticacaoModel>(context)
                      .funcionarioModel!.nome
                      .toString(),
                  cor: colorBranco,
                ),
              ],
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.8,
            height: mediaQuery.size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  itemMenu('Fornecedor', context, '/cadastrar_fornecedor'),
                  itemMenu('Produto', context, '/cadastrar_produto'),
                  itemMenu('Precificação', context, '/cadastrar_precificacao'),
                  itemMenu('Estoque', context, '/estoque'),
                  itemMenu(
                      'Pedido de Compras', context, '/pedido_compra_cadastrar'),
                  itemMenu('Cliente', context, '/cadastrar_cliente'),
                  itemMenu(
                      'Pedido de venda', context, '/pedido_venda_cadastrar')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget itemMenu(String nome, BuildContext context, String rota) {
  var mediaQuery = MediaQuery.of(context);
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, rota),
    child: Container(
      padding: paddingPadrao,
      height: mediaQuery.size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            label: nome,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
