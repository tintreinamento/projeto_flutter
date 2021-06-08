import 'package:flutter/material.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

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
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [Text('CPF/CNPJ'), TextField()],
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Consultar'))
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
