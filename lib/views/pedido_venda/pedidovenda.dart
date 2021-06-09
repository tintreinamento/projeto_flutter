import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/input.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

class PedidoVenda extends StatefulWidget {
  const PedidoVenda({Key? key}) : super(key: key);

  @override
  _PedidoVendaState createState() => _PedidoVendaState();
}

class _PedidoVendaState extends State<PedidoVenda> {
  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponente(appBar: AppBar()),
      drawer: DrawerComponente(),
      body: Center(
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 330,
              height: 120,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(191, 188, 188, 1), width: 1)),
              child: Column(
                children: [
                  inputComponente('CEP', cepController),
                  inputComponente('Logradouro', logradouroController),
                  inputComponente('Número', numeroController),
                  inputComponente('Bairro', bairroController),
                  inputComponente('Cidade', cidadeController),
                  inputComponente('Estado', estadoController)
                ],
              ),
            ),
            Text(
              'Pedido venda',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
