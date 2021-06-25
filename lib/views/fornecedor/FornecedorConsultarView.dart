import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:flutter/material.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';

import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';

class FornecedorConsultarView extends StatefulWidget {
  const FornecedorConsultarView({Key? key}) : super(key: key);

  @override
  _FornecedorConsultarViewState createState() => _FornecedorConsultarViewState();
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
      //consulta
      /*var nomeFornecedor = nomeController;
      FornecedorController fornecedor = new FornecedorController();
      void initState() {
        super.initState();
        listaFornecedores = fornecedorController.obtenhaPorNome(nomeFornecedor.text) as Future<List<FornecedorModel>>;
      }*/
    }



  }

  @override
  void initState() {
    super.initState();
    listaFornecedores = fornecedorController.obtenhaTodos();
  }

  @override
  Widget build(BuildContext context) {
    final formConsulta = Form(
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
          )
        ],
      ),
    );

    //Map
    var lista = FutureBuilder(
        future: listaFornecedores,
        builder:
            (BuildContext context, AsyncSnapshot<List<FornecedorModel>> snapshot) {
          if (snapshot.hasData) {
            final listaFornecedores = snapshot.data!.map((fornecedor) {
              return Column(
                children: [
                  cardFornecedor(fornecedor),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }).toList();

            return Column(
              children: [
                ...listaFornecedores,
              ],
            );
          } else if (snapshot.hasError) {
            // If something went wrong
            return Text('Falha ao obter os dados da API ');
          }
          return CircularProgressIndicator();
        });

    final layoutVertical = Container(
      child: Column(
        children: [
          SubMenuComponent(
            titulo: 'Cliente',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_cliente',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_cliente',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  FormComponent(
                    label: 'Fornecedor',
                    content: formConsulta,
                  ),
                  ButtonComponent(
                    label: 'Consultar',
                    onPressed: consultarFornecedor,
                  ),
                  FormComponent(
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
            titulo: 'Cliente',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_cliente',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_cliente',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Row(
                children: [
                  FormComponent(
                    label: 'Fornecedor',
                    content: formConsulta,
                  ),
                  ButtonComponent(
                    label: 'Consultar',
                    onPressed: consultarFornecedor,
                  ),
                  FormComponent(
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

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxHeight < 600) {
              return layoutVertical;
            } else {
              return layoutHorizontal;
            }
          },
        ));
  }
}

Widget cardFornecedor(FornecedorModel fornecedorModel) {
  return Container(
      padding: EdgeInsets.all(16),
      color: Color.fromRGBO(235, 231, 231, 1),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  TextComponent(
                    label: 'Nome: ',
                  ),
                  TextComponent(
                    label: fornecedorModel.nome,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  TextComponent(
                    label: 'CPF/CNPJ: ',
                  ),
                  TextComponent(
                    label: fornecedorModel.cpfCnpj,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  TextComponent(
                    label: 'Telefone: ',
                  ),
                  TextComponent(
                    label: fornecedorModel.telefone,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  TextComponent(
                    label: 'E-mail: ',
                  ),
                  TextComponent(
                    label: fornecedorModel.email,
                  ),
                ],
              )
            ],
          ),
          Positioned(
            top: 50,
            right: 0,
            child: FlatButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/login');
                },
                child: Container(
                    child: Image(image: AssetImage('assets/images/edit.png')))),
          ),
        ],
      ));
}
