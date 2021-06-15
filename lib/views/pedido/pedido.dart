import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/boxdecoration.dart';
import 'package:projeto_flutter/componentes/inputdecoration.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
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

//Produto
import '../../controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

//Pedido
import '../../models/PedidoModel.dart';

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

  //Produto
  final parametroNomeProdutoController = TextEditingController();
  late Future<List<ProdutoModel>> listaProduto;

  //Pedido
  List<ItemPedidoModel> listaItemPedido = [];
  var precoTotal = 0.0;

  consultarCliente() async {
    var cpfCnpjCliente = '';
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
    this.cpfCnpjController.text = cpfCnpjCliente;
    nomeClienteController.text = cliente.nome;

    //Preenche os dados de endereço do cliente
    cepController.text = UtilBrasilFields.obterCep(cliente.cep);
    logradouroController.text = cliente.logradouro;
    numeroController.text = cliente.numero.toString();
    bairroController.text = cliente.bairro;
    cidadeController.text = cliente.cidade;
    estadoController.text = cliente.uf;
  }

  limparCampos() {
    parametrocpfCnpjController.text = '';
    cpfCnpjController.text = '';
    nomeClienteController.text = '';
    cepController.text = '';
    logradouroController.text = '';
    numeroController.text = '';
    bairroController.text = '';
    cidadeController.text = '';
    estadoController.text = '';

    parametroNomeProdutoController.text = '';
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

  finalizarPedido(BuildContext context) {
    limparCampos();
    PedidoModel pedido =
        new PedidoModel(id: 1, total: 100.0, data: DateTime.now());
    _showDialog(context, pedido);
  }

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  void carregarProdutos() {
    ProdutoController produtoController = new ProdutoController();
    listaProduto = produtoController.obtenhaTodos();
  }

  ordenarProduto(nomeProduto) {
    setState(() {
      parametroNomeProdutoController.text = nomeProduto;
    });
  }

  adicionarItemPedido(ProdutoModel produto) {
    setState(() {
      int index = listaItemPedido.indexWhere((itemPedido) {
        return itemPedido.produto!.id == produto.id;
      });

      if (index < 0) {
        ItemPedidoModel itemPedido = new ItemPedidoModel(
            produto: produto, quantidade: 1, subtotal: produto.valorVenda);
        listaItemPedido.add(itemPedido);
      } else {
        listaItemPedido[index].quantidade++;
        listaItemPedido[index].subtotal += produto.valorVenda;
      }
      getPrecoTotal();
    });
  }

  removerItemPedido(ProdutoModel produto) {
    setState(() {
      int index = listaItemPedido.indexWhere((itemPedido) {
        return itemPedido.produto!.id == produto.id;
      });

      if (index < 0) {
        //Não existe o produto
      } else {
        listaItemPedido[index].quantidade--;
        listaItemPedido[index].subtotal -= produto.valorVenda;
      }
      getPrecoTotal();
    });
  }

  getQuantidade(produto) {
    int index = listaItemPedido.indexWhere((itemPedido) {
      return itemPedido.produto!.id == produto.id;
    });

    if (index < 0) {
      return 0;
    }

    return listaItemPedido[index].quantidade;
  }

  void _showDialog(BuildContext context, PedidoModel pedido) {
    final listaItem = listaItemPedido.map((itemPedido) {
      return Column(
        children: [
          Container(
            width: 270,
            height: 68,
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 68,
                  padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  color: Color.fromRGBO(235, 231, 231, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nome: ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          Text(
                            itemPedido.produto!.nome,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Categoria:',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Valor de venda: ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          Text(
                            itemPedido.produto!.valorVenda.toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 68,
                  child: Column(
                    children: [
                      Container(
                        width: 46,
                        height: 45,
                        alignment: Alignment.center,
                        child:
                            Text(getQuantidade(itemPedido.produto!).toString(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Pedido"),
          actions: <Widget>[
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Cliente: ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        Text('Dado')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Data do pedido: ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        Text('Dado')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Valor total do pedido: ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        Text('Dado')
                      ],
                    ),
                    Divider(),
                    Text(
                      'Itens do pedido',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    ...listaItem,
                  ],
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
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Color.fromRGBO(0, 94, 181, 1),
            actions: [],
            flexibleSpace: Container(
              height: 100.0,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: 73.0,
                      padding: EdgeInsets.only(top: 30, right: 6, bottom: 5),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Sistema de Gestão de Vendas',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(73.0)),
      drawer: DrawerComponente(),
      body: Column(
        children: [
          Flexible(
              child: Container(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 7),
            height: 27,
            color: Color.fromRGBO(206, 5, 5, 1),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 38),
                  child: Text('Pedido venda ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      )),
                ),
                Text('|',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 13),
                  child: Text('Cadastrar ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      )),
                ),
                Text('|',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 13),
                  child: Text('Consultar ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      )),
                ),
                Text('|',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    )),
              ],
            ),
          )),
          Container(
            height: 640,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                      Positioned(
                          top: 9,
                          left: 50,
                          child: Container(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(
                              'CONSULTA',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Stack(
                    children: [
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
                      Positioned(
                          top: 9,
                          left: 50,
                          child: Container(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(
                              'CLIENTE',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Stack(
                    children: [
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
                      Positioned(
                          top: 9,
                          left: 50,
                          child: Container(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(
                              'ENDEREÇO',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Stack(
                    children: [
                      FutureBuilder(
                          future: listaProduto,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ProdutoModel>> snapshot) {
                            if (snapshot.hasData) {
                              // Data fetched successfully, display your data here

                              final listaProdutoOrdenada =
                                  snapshot.data!.where((produto) {
                                return produto
                                    .getNome()
                                    .toLowerCase()
                                    .startsWith(
                                        parametroNomeProdutoController.text);
                              });

                              final listaProduto =
                                  listaProdutoOrdenada.map((produto) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 284,
                                      height: 68,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 238,
                                            height: 68,
                                            padding: EdgeInsets.only(
                                                left: 12, top: 6, bottom: 6),
                                            color: Color.fromRGBO(
                                                235, 231, 231, 1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Nome: ',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      produto.nome,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Categoria:',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Valor de venda: ',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      produto.valorVenda
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 46,
                                            height: 68,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 46,
                                                  height: 45,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      getQuantidade(produto)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      )),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 23,
                                                      height: 23,
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color.fromRGBO(
                                                                          8,
                                                                          201,
                                                                          62,
                                                                          1)),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                              ))),
                                                          onPressed: () {
                                                            adicionarItemPedido(
                                                                produto);
                                                          },
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      width: 23,
                                                      height: 23,
                                                      // margin: EdgeInsets.only(top: 18, bottom: 13),
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color.fromRGBO(
                                                                          206,
                                                                          5,
                                                                          5,
                                                                          1)),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                              ))),
                                                          onPressed: () {
                                                            removerItemPedido(
                                                                produto);
                                                          },
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList();

                              return Container(
                                  width: 330,
                                  margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
                                  padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
                                  decoration: boxDecorationComponente,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Produto:',
                                              style: textStyleComponente,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 3),
                                              width: 230,
                                              height: 31,
                                              child: TextField(
                                                onChanged: (nomeProduto) {
                                                  ordenarProduto(nomeProduto);
                                                },
                                                decoration:
                                                    inputDecorationComponente,
                                              ),
                                            )
                                          ],
                                        ),
                                        ...listaProduto,
                                      ],
                                    ),
                                  ));
                            } else if (snapshot.hasError) {
                              // If something went wrong
                              return Text('Something went wrong...');
                            }

                            // While fetching, show a loading spinner.
                            return CircularProgressIndicator();
                          }),
                      Positioned(
                          top: 9,
                          left: 50,
                          child: Container(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(
                              'PRODUTOS',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          )),
                    ],
                  ),
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
                      onPressed: () {
                        finalizarPedido(context);
                      },
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
