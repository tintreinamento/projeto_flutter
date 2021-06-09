import 'package:flutter/material.dart';
import 'package:projeto_flutter/classes/endereco.dart';
import 'package:projeto_flutter/componentes/input.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/services/apicorreios.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

import '../../classes/endereco.dart';
import 'dart:convert';
import '../../services/apicorreios.dart';

//http

import 'package:http/http.dart' as http;

class PedidoVenda extends StatefulWidget {
  const PedidoVenda({Key? key}) : super(key: key);

  @override
  _PedidoVendaState createState() => _PedidoVendaState();
}

class _PedidoVendaState extends State<PedidoVenda> {
  late Future<Endereco> futureEndereco;
  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  void handleSubmittedCep() async {
    print(cepController.text);

    // var endereco = getEndereco('01001000');
    //print(endereco);

    var endereco = await getEndereco(cepController.text);

    //Seta valores nos campos de endereço
    logradouroController.text = endereco['logradouro'];
    complementoController.text = endereco['complemento'];
    bairroController.text = endereco['bairro'];
    cidadeController.text = endereco['localidade'];
    estadoController.text = endereco['uf'];

    print(endereco['cep']);
  }

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textComponente('Entrega'),
                        Divider(),
                        inputComponente(
                            'CEP:', cepController, handleSubmittedCep),
                        inputComponente(
                            'Logradouro:', logradouroController, () {}),
                        inputComponente(
                            'Complemento:', complementoController, () {}),
                        inputComponente('Bairro:', bairroController, () {}),
                        inputComponente('Cidade:', cidadeController, () {}),
                        inputComponente('Estado:', estadoController, () {})
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
