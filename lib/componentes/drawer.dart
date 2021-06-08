import 'package:flutter/material.dart';

class DrawerComponente extends StatelessWidget {
  Widget headerMenu() {
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
                        left: 0,
                        child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/return.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
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
                        child: Text(
                          'Sair',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 1,
                        left: 320,
                        child: Icon(Icons.arrow_back_ios, color: Colors.grey)),
                  ]))),
        ]));
  }

  //Item do menu
  Widget itemMenu(String titulo) {
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
          // Update the state of the app
          // ...
          // Then close the drawer
          //avigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 368,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Figma Flutter Generator Group62Widget - GROUP
            headerMenu(),
            itemMenu('Fornecedor'),
            itemMenu('Produto'),
            itemMenu('Precificação'),
            itemMenu('Estoque'),
            itemMenu('Pedido de compras'),
            itemMenu('Cliente'),
            itemMenu('Pedido de venda'),
          ],
        ),
      ),
    );
  }
}
