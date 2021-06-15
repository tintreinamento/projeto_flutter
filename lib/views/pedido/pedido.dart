import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/boxdecoration.dart';
import 'package:projeto_flutter/componentes/inputdecoration.dart';
import 'package:projeto_flutter/models/produto.dart';
import 'package:projeto_flutter/views/pedido/buscarproduto.dart';
import '../../componentes/appbar.dart';
import '../../componentes/drawer.dart';

import '../pedido/endereco.dart';

import '../../componentes/textstyle.dart';
import '../../componentes/inputdecoration.dart';
import '../../componentes/boxdecoration.dart';

import '../../controllers/ClienteController.dart';
import '../../controllers/EnderecoController.dart';

import '../../models/ItemPedidoModel.dart';

import 'package:intl/intl.dart';

class Pedido extends StatefulWidget {
  //EnderecoModel? enderecoModel;
  List<ProdutoModels> listaProduto = [];

  //Pedido({Key? key, this.enderecoModel}) : super(key: key);

  //changeEndereco(EnderecoModel endereco) {
  //this.enderecoModel = endereco;
  //}

  //Adiciona produto
  handleAdicionarProduto(ProdutoModels produtoModel) {
    int index = listaProduto
        .indexWhere((produto) => produto.idProduto == produtoModel.idProduto);

    //Caso não existe o produto da lista adiciona
    if (index < 0) {
      listaProduto.add(produtoModel);
    } else {
      listaProduto[index] = produtoModel;
    }
    print('produto.getNome()');
    for (var produto in listaProduto) {
      print(produto.getNome());
      print(produto.getQuantidade());
    }
  }

  //Remove produto
  handleRemoveProduto(ProdutoModels produtoModels) {
    listaProduto.remove(produtoModels);
  }

  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  final _formKeyConsultarCliente = GlobalKey<FormState>();

  //Cliente
  final parametrocpfCnpjController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final nomeClienteController = TextEditingController();

  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  //Pedido
  List<ItemPedidoModel> listaItemPedido = [];
  var precoTotal = 0.0;

  consultarCliente() async {
    var cpfCnpjCliente;
    //Consultando dados do cliente através da API
    ClienteController clienteController = new ClienteController();
    final cliente = await clienteController.obtenhaPorCpf(
        UtilBrasilFields.removeCaracteres(parametrocpfCnpjController.text));

    //Caso seja cpf, aplica-se a máscara de CPF, caso contrário aplica-se a máscara de CNPJ
    if (cliente.cpf.length == 11) {
      cpfCnpjCliente = UtilBrasilFields.obterCpf(cliente.cpf);
    } else if (cliente.cpf.length == 14) {
      cpfCnpjCliente = UtilBrasilFields.obterCnpj(cliente.cpf);
    }
    //Caso exista o cliente cadastrado, preencha os campos com as respectivas informações
    cpfCnpjController.text = cpfCnpjCliente;
    nomeClienteController.text = cliente.nome;

    //Preenche os dados de endereço do cliente
    cepController.text = UtilBrasilFields.obterCep(cliente.cep);
    logradouroController.text = cliente.logradouro;
    numeroController.text = cliente.numero.toString();
    bairroController.text = cliente.bairro;
    cidadeController.text = cliente.cidade;
    estadoController.text = cliente.uf;
  }

  consultarEndereco(String cep) async {
    EnderecoController enderecoController = new EnderecoController();

    final endereco = await enderecoController
        .obtenhaEnderecoPorCep(UtilBrasilFields.removeCaracteres(cep));

    logradouroController.text = endereco.logradouro;
    numeroController.text = '';
    bairroController.text = endereco.bairro;
    cidadeController.text = endereco.cidade;
    estadoController.text = endereco.uf;
  }

  carregarListaItemPedido(listaItemPedido) {
    setState(() {
      this.listaItemPedido = listaItemPedido;
      getPrecoTotal();
    });
  }

  getPrecoTotal() {
    setState(() {
      precoTotal = 0.0;
      for (var itemPedido in this.listaItemPedido) {
        precoTotal += itemPedido.subtotal;
      }
    });
  }

  getPrecoTotalFormatado() {
    var formatoPreco = NumberFormat("#,##0.00", "pt_BR");
    return 'R\$ ' + formatoPreco.format(precoTotal).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponente(appBar: AppBar()),
      drawer: DrawerComponente(),
      body: Column(
        children: [
          Container(
            height: 520,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Consultar cliente
                  Form(
                    key: _formKeyConsultarCliente,
                    child: Container(
                      width: 330,
                      margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
                      padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
                      decoration: boxDecorationComponente,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'CPF/CNPJ:',
                                style: textStyleComponente,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3),
                                width: 230,
                                height: 31,
                                child: TextFormField(
                                  controller: parametrocpfCnpjController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Informe o CPF ou CNPJ';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CpfOuCnpjFormatter()
                                  ],
                                  decoration: inputDecorationComponente,
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 241,
                            height: 31,
                            margin: EdgeInsets.only(top: 18, bottom: 13),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(0, 94, 181, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ))),
                                onPressed: () {
                                  if (_formKeyConsultarCliente.currentState!
                                      .validate()) {
                                    consultarCliente();
                                  }
                                },
                                child: Text(
                                  'Consultar',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Cliente
                  Container(
                    width: 330,
                    margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
                    padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
                    decoration: boxDecorationComponente,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Nome:',
                              style: textStyleComponente,
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 3),
                              width: 260,
                              height: 31,
                              child: TextField(
                                controller: nomeClienteController,
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'CPF/CNPJ:',
                              style: textStyleComponente,
                            ),
                            Container(
                              //  margin: EdgeInsets.only(left: 2),
                              width: 233,
                              height: 31,
                              child: TextField(
                                controller: cpfCnpjController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CpfOuCnpjFormatter()
                                ],
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Entrega
                  Container(
                    width: 330,
                    margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
                    padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
                    decoration: boxDecorationComponente,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              'CEP:',
                              style: textStyleComponente,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 260,
                              height: 31,
                              child: TextField(
                                onSubmitted: (cep) {
                                  consultarEndereco(cep);
                                },
                                controller: cepController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CepInputFormatter()
                                ],
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'Logradouro:',
                              style: textStyleComponente,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              width: 224,
                              height: 31,
                              child: TextField(
                                controller: logradouroController,
                                decoration: inputDecorationComponente,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Num.:',
                                  style: textStyleComponente,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 9),
                                  width: 73,
                                  height: 31,
                                  child: TextField(
                                    controller: numeroController,
                                    decoration: inputDecorationComponente,
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Bairro:',
                                    style: textStyleComponente,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4),
                                    width: 128,
                                    height: 31,
                                    child: TextField(
                                      controller: bairroController,
                                      decoration: inputDecorationComponente,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Cidade:',
                                  style: textStyleComponente,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 1),
                                  width: 115,
                                  height: 31,
                                  child: TextField(
                                    controller: cidadeController,
                                    decoration: inputDecorationComponente,
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Text(
                                    'Estado:',
                                    style: textStyleComponente,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    width: 73,
                                    height: 31,
                                    child: TextField(
                                      controller: estadoController,
                                      decoration: inputDecorationComponente,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  BuscarProduto(
                    carregarListaItemPedido: carregarListaItemPedido,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 367,
            height: 66,
            color: Color.fromRGBO(255, 255, 255, 1),
            child: Row(
              children: [
                Container(
                  width: 206,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'por',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 108, 197, 1),
                        ),
                      ),
                      Text(
                        getPrecoTotalFormatado(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color.fromRGBO(0, 108, 197, 1),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 161,
                  height: 66,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(0, 184, 0, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ))),
                      onPressed: () {},
                      child: Container(
                          child: Image(
                              image: AssetImage('assets/images/cart.png')))),
                )
              ],
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
