import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:flutter/material.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';

import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';

class ClienteConsultarView extends StatefulWidget {
  const ClienteConsultarView({Key? key}) : super(key: key);

  @override
  _ClienteConsultarViewState createState() => _ClienteConsultarViewState();
}

class _ClienteConsultarViewState extends State<ClienteConsultarView> {
  final _formKeyConsultaCliente = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  ClienteController clienteController = new ClienteController();
  Future<List<ClienteModel>>? listaClientes;

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarCliente() {
    if (_formKeyConsultaCliente.currentState!.validate()) {
      //consulta
      setState(() {});
    }
  }

  carregarCliente() {
    listaClientes = clienteController.obtenhaTodos();
  }

  @override
  void initState() {
    super.initState();
    carregarCliente();
  }

  @override
  Widget build(BuildContext context) {
    final formConsulta = Form(
      key: _formKeyConsultaCliente,
      child: Column(
        children: [
          InputComponent(
            label: 'Nome:',
            controller: nomeController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo nome vazio !';
              }
              return null;
            },
          ),
          ButtonComponent(
            label: 'Consultar',
            onPressed: consultarCliente,
          ),
        ],
      ),
    );

    //Map
    var lista = FutureBuilder(
        future: listaClientes,
        builder:
            (BuildContext context, AsyncSnapshot<List<ClienteModel>> snapshot) {
          if (snapshot.hasData) {
            //Ordena consulta
            final listaOrdenada = snapshot.data!.where((cliente) {
              return cliente.nome!
                  .toLowerCase()
                  .startsWith(nomeController.text.toLowerCase());
            });

            final listaClientes = listaOrdenada.map((cliente) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    cardCliente(cliente),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }).toList();

            return Column(
              children: [
                ...listaClientes,
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
                  MolduraComponent(
                    label: 'Cliente',
                    content: formConsulta,
                  ),
                  MolduraComponent(
                    label: 'Clientes',
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
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MolduraComponent(
                      label: 'Cliente',
                      content: formConsulta,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: MolduraComponent(
                      label: 'Clientes',
                      content: lista,
                    ),
                  ))
                ],
              ),
            ),
          )
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

String getCpfCnpj(String value) {
  String cpfCnpj = "";

  if (value.length == 10) {
    value = '0' + value;
  } else if (value.length == 9) {
    value = '00' + value;
  }

  if (value.length == 11) {
    cpfCnpj = UtilBrasilFields.obterCpf(value);
  } else if (value.length == 14) {
    cpfCnpj = UtilBrasilFields.obterCnpj(value);
  }

  return cpfCnpj;
}

Widget cardCliente(ClienteModel clienteModel) {
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
                  children: [
                    TextComponent(
                      label: 'Nome: ',
                    ),
                    TextComponent(
                      label: clienteModel.nome,
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
                      label: getCpfCnpj(clienteModel.cpf.toString()),
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
                      label: UtilBrasilFields.obterTelefone(
                          clienteModel.ddd.toString() +
                              clienteModel.numeroTelefone.toString()),
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
                      label: clienteModel.email,
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
