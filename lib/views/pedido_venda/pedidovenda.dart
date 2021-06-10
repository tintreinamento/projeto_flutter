import 'package:flutter/material.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

import '../pedido_venda/endereco.dart';

class PedidoVenda extends StatefulWidget {
  const PedidoVenda({Key? key}) : super(key: key);

  @override
  _PedidoVendaState createState() => _PedidoVendaState();
}

class _PedidoVendaState extends State<PedidoVenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponente(appBar: AppBar()),
      drawer: DrawerComponente(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: 330,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(191, 188, 188, 1), width: 1)),
                  child: Flexible(
                    child: Endereco(), //Componente de formulário de endereço
                  )),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
