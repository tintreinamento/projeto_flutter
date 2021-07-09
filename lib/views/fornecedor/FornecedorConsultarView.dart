import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:flutter/material.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';

import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';

class FornecedorConsultarView extends StatefulWidget {
  const FornecedorConsultarView({Key? key}) : super(key: key);

  @override
  _FornecedorConsultarViewState createState() =>
      _FornecedorConsultarViewState();
}

class _FornecedorConsultarViewState extends State<FornecedorConsultarView> {
  final _formKeyConsultaFornecedor = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  FornecedorController fornecedorController = new FornecedorController();
  late Future<List<FornecedorModel>> listaFornecedores;

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarFornecedor() async {
    if (_formKeyConsultaFornecedor.currentState!.validate()) {
      var fornecedores = (await fornecedorController.obtenhaTodos())
                .where((element) => element.nome.toLowerCase().contains(nomeController.text.toLowerCase()));
      if (fornecedores.length == 0) {
        mensagem('Nenhum fornecedor com esse nome encontrado!');
        nomeController.clear();
      }

      setState(() {});
    }
  }

  Future<void> mensagem(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensagem'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    listaFornecedores = fornecedorController.obtenhaTodos();
  }

  @override
  Widget build(BuildContext context) {
    final formConsulta = Form(
      key: _formKeyConsultaFornecedor,
      child: Column(
        children: [
          InputComponent(
            label: 'Nome:',
            controller: nomeController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo nome vazio!';
              }
              return null;
            },
          ),
          ButtonComponent(
            label: 'Consultar',
            onPressed: consultarFornecedor,
          ),
        ],
      ),
    );
    //Map
    var lista = FutureBuilder(
        future: listaFornecedores,
        builder: (BuildContext context,
            AsyncSnapshot<List<FornecedorModel>> snapshot) {
          if (snapshot.hasData) {
            //Ordena consulta
            final listaOrdenada = snapshot.data!.where((fornecedor) {
              return fornecedor.nome!
                  .toLowerCase()
                  .contains(nomeController.text.toLowerCase());
            });
            final listaFornecedores = listaOrdenada.map((fornecedor) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    cardFornecedor(fornecedor),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }).toList();
            
            return Column(
              children: [
                ...listaFornecedores,
              ],
            );
          } else if (snapshot.hasError) {
            // If something went wrong
            return Text('Falha ao obter os dados da API');
          }
          return CircularProgressIndicator();
        });

    final layoutVertical = Container(
      child: Column(
        children: [
          SubMenuComponent(
            titulo: 'Fornecedor',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_fornecedor',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_fornecedor',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              //width: double.infinity,
              //height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  MolduraComponent(
                    label: 'Fornecedor',
                    content: formConsulta,
                  ),
                  MolduraComponent(
                    label: 'Fornecedores',
                    content: lista,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );

    final layoutHorizontal = Container(
      child: Column(
        children: [
          SubMenuComponent(
            titulo: 'Fornecedor',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_fornecedor',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_fornecedor',
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MolduraComponent(
                      label: 'Fornecedor',
                      content: formConsulta,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: MolduraComponent(
                      label: 'Fornecedores',
                      content: lista,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // if (constraints.maxHeight > 600) {
            return layoutVertical;
            // } else {
            //   return layoutHorizontal;
            // }
          },
        ));
  }
}

Widget cardFornecedor(FornecedorModel fornecedorModel) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: 340.0),
    child: Container(
        padding: EdgeInsets.all(10),
        color: Color.fromRGBO(235, 231, 231, 1),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'Nome: ',
                    ),
                    Expanded(child: Text(fornecedorModel.nome)),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'CPF/CNPJ: ',
                    ),
                    Expanded(child: Text((fornecedorModel.cpfCnpj).toString())),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'Telefone: ',
                    ),
                    Expanded(
                        child: Text((fornecedorModel.telefone).toString())),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'E-mail: ',
                    ),
                    Expanded(child: Text(fornecedorModel.email)),
                  ],
                )
              ],
            ),
          ],
        )),
  );
}
