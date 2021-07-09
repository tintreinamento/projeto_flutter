import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';

class ClienteConsultaView extends StatefulWidget {
  const ClienteConsultaView({Key? key}) : super(key: key);

  @override
  _ClienteConsultaViewState createState() => _ClienteConsultaViewState();
}

class _ClienteConsultaViewState extends State<ClienteConsultaView> {
  final _formConsultarCliente = GlobalKey<FormState>();
  ClienteController clienteController = ClienteController();
  Future<List<ClienteModel?>?>? clientes;
  String buscarClienteNome = "";
  final clienteBuscarController = TextEditingController();

  consultarCliente() {
    if (_formConsultarCliente.currentState!.validate()) {
      setState(() {
        clientes = clienteController.obtenhaTodos();

        buscarClienteNome = clienteBuscarController.text;
      });
      _formConsultarCliente.currentState!.reset();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    clientes = clienteController.obtenhaTodos();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    print(buscarClienteNome);

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            child: Column(children: [
              SubMenuComponent(
                titulo: 'Cliente',
                tituloPrimeiraRota: 'Cadastro',
                primeiraRota: '/cadastrar_cliente',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/consultar_cliente',
              ),
              Expanded(
                  child: Container(
                padding: paddingPadrao,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      MolduraComponent(
                        label: 'Cliente',
                        content: Form(
                          key: _formConsultarCliente,
                          child: Column(
                            children: [
                              InputComponent(
                                label: 'Nome: ',
                                controller: clienteBuscarController,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Campo obrigátorio!';
                                  }
                                  return null;
                                },
                              ),
                              ButtonComponent(
                                label: 'Consultar',
                                onPressed: consultarCliente,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FutureBuilder(
                          future: clientes,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ClienteModel?>?>? snapshot) {
                            if (snapshot != null) {
                              if (snapshot.hasData) {
                                final clientesOrdenado =
                                    snapshot.data!.where((cliente) {
                                  final regexp = new RegExp(
                                      buscarClienteNome.toLowerCase());

                                  return regexp.hasMatch(
                                      cliente!.nome.toString().toLowerCase());
                                }).toList();

                                print(clientesOrdenado);

                                clientesOrdenado.forEach((element) {
                                  print(element!.nome);
                                });

                                //Verifica se nenhum resultado foi encontrado
                                if (clientesOrdenado.length == 0) {
                                  return TextComponent(
                                    label: 'Nenhum cliente foi encontrado !',
                                  );
                                }

                                final clientesWidget =
                                    clientesOrdenado.map((cliente) {
                                  return cardCliente(context, cliente!);
                                }).toList();

                                return Container(
                                  height: mediaQuery.size.height * 0.7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [...clientesWidget],
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                TextComponent(
                                  label: 'Nenhum cliente foi encontrado !',
                                );
                              } else {
                                return Column(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextComponent(
                                      label: 'Buscando clientes...',
                                    )
                                  ],
                                );
                              }
                            }
                            return Container();
                          })
                    ],
                  ),
                ),
              ))
            ])));
  }
}

Widget cardCliente(BuildContext context, ClienteModel cliente) {
  var mediaQuery = MediaQuery.of(context);
  String cpfCnpj = "";
  String telefone = cliente.ddd.toString() + cliente.numeroTelefone.toString();

  telefone = UtilBrasilFields.obterTelefone(telefone);
  print(cliente.cpf);
  if (UtilBrasilFields.removeCaracteres(cliente.cpf.toString()).length == 11) {
    cpfCnpj = UtilBrasilFields.obterCpf(
        UtilBrasilFields.removeCaracteres(cliente.cpf.toString()));
  }
  if (UtilBrasilFields.removeCaracteres(cliente.cpf.toString()).length == 14) {
    cpfCnpj = UtilBrasilFields.obterCnpj(
        UtilBrasilFields.removeCaracteres(cliente.cpf.toString()));
  }

  return Stack(
    children: [
      Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height * 0.25,
        margin: marginPadrao,
        padding: paddingPadrao,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colorCinza,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextComponent(
                    label: 'Nome: ',
                    fontWeight: FontWeight.bold,
                  ),
                  TextComponent(label: cliente.nome.toString())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextComponent(
                    label: 'CPF/CNPJ: ',
                    fontWeight: FontWeight.bold,
                  ),
                  TextComponent(label: cpfCnpj)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextComponent(
                    label: 'Telefone: ',
                    fontWeight: FontWeight.bold,
                  ),
                  TextComponent(label: telefone)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    label: 'E-mail: ',
                    fontWeight: FontWeight.bold,
                  ),
                  Flexible(
                    child: new Container(
                      child: new Text(
                        cliente.email.toString(),
                        maxLines: 4,
                        style: new TextStyle(
                          fontFamily: 'Roboto',
                          color: new Color(0xFF212121),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //Button para edição
      // Positioned(
      //     right: 20,
      //     bottom: 20,
      //     child: IconButton(
      //       color: colorAzul,
      //         icon: Icon(Icons.edit),
      //         onPressed: () => print('edit')))
    ],
  );
}

_showDialog(context, info) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Column(children: [
              TextComponent(
                label: info.toString(),
              ),
              Container(
                width: 241,
                height: 31,
                margin: EdgeInsets.only(top: 18, bottom: 13),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(0, 94, 181, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Confirmar pedido',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    )),
              )
            ])
          ],
        );
      });
}
