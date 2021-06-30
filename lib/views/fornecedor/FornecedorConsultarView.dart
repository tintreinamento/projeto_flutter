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

  consultarFornecedor() {
    if (_formKeyConsultaFornecedor.currentState!.validate()) {
      //consulta
      setState(() {});
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
              return fornecedor.nome
                  .toLowerCase()
                  .startsWith(nomeController.text.toLowerCase());
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
                  FormComponent(
                    label: 'Fornecedor',
                    content: formConsulta,
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
            titulo: 'Fornecedor',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_cliente',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_cliente',
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FormComponent(
                      label: 'Fornecedor',
                      content: formConsulta,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: FormComponent(
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
            if (constraints.maxHeight > 600) {
              return layoutVertical;
            } else {
              return layoutHorizontal;
            }
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
                    /*Expanded(child: Text( fornecedorModel.nome)),*/
                    TextComponent(
                      label: fornecedorModel.nome,
                    ),
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
                    TextComponent(
                      label: fornecedorModel.cpfCnpj,
                    ),
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
                    TextComponent(
                      label: fornecedorModel.telefone,
                    ),
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
                    TextComponent(
                      label: fornecedorModel.email,
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: 50,
              right: -10,
              child: FlatButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                      child:
                          Image(image: AssetImage('assets/images/edit.png')))),
            ),
          ],
        )),
  );
}
