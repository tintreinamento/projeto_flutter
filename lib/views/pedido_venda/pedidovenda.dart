import 'package:flutter/material.dart';
import 'package:projeto_flutter/views/pedido_venda/buscarproduto.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

import '../pedido_venda/endereco.dart';

class PedidoVenda extends StatefulWidget {
  Endereco? endereco;

  PedidoVenda({Key? key, this.endereco}) : super(key: key);

  changeEndereco(Endereco endereco) {
    this.endereco = endereco;
    print('teste');
  }

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
        child: Column(
          children: [
            Endereco(changeEndereco: widget.changeEndereco),
            BuscarProduto()
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
