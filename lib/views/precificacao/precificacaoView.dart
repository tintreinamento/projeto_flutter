import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/controllers/ProdutoMargemController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ProdutoMargemModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class PrecificacaoView extends StatefulWidget {
  const PrecificacaoView({Key? key}) : super(key: key);

  @override
  _PrecificacaoViewState createState() => _PrecificacaoViewState();
}

class ProdutoCategoriaModel {
  var produto = new ProdutoModel();
  var categoriaModel = new CategoriaModel();
}

class _PrecificacaoViewState extends State<PrecificacaoView> {
  final _formKeyPrecificacao = GlobalKey<FormState>();
  final margemController = TextEditingController();
  var produtoModelGlobal = new ProdutoModel();
  var produtoMargemModelGlobal = new ProdutoMargemModel();

  var produtoController = new ProdutoController();
  var produtoMargemController = new ProdutoMargemController();

  late Future<List<ProdutoCategoriaModel>?> listaProdutos;

  TextEditingController valorCompraController = new TextEditingController();
  TextEditingController valorVendaController = new TextEditingController();
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarProduto() {
    if (_formKeyPrecificacao.currentState!.validate()) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    listaProdutos = produtoController.obtenhaTodosComCategoria();
  }

  //Pop up para alterar a margem
  Future<void> _abrirDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Alterar Margem',
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * .4,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  //flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Produto:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Produto:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(produtoModelGlobal.id.toString()),
                      Text(produtoModelGlobal.nome.toString())
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Valor Compra:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Valor Venda:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(valorCompraController.text =
                          formatter.format(produtoModelGlobal.valorCompra)),
                      Text(valorVendaController.text =
                          formatter.format(produtoModelGlobal.valorVenda)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\nMargem: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                          child: TextField(
                        textAlign: TextAlign.center,
                        controller: margemController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ))
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonComponent(
                            label: 'Cadastrar',
                            onPressed: () async {
                              await cadastrarMargem();
                              setState(() {});
                              Navigator.of(context).pop();
                            }),
                      ],
                    ))
              ]),
            ),
          );
        });
  }

  cadastrarMargem() async {
    var produtoMargemController = new ProdutoMargemController();
    var produtoController = new ProdutoController();
    var colecaoDeProdutoMargem = await produtoMargemController.obtenhaTodos();

    var margem = double.parse(margemController.text);

    if (margem >= 100.00) {
      mensagemErroMargemErrada();
      return _abrirDialog(context);
    } else {
      produtoMargemModelGlobal.margem = margem;
      produtoMargemModelGlobal.idProduto = produtoModelGlobal.id;

      var produtoMargemBanco = colecaoDeProdutoMargem!
          .where((element) => element.idProduto == produtoModelGlobal.id);

      produtoModelGlobal.valorVenda = produtoModelGlobal.valorCompra +
          (produtoModelGlobal.valorCompra * margem / 100);

      await produtoController.atualize(produtoModelGlobal);

      if (produtoMargemBanco.isNotEmpty) {
        produtoMargemModelGlobal.id = produtoMargemBanco.single.id;
        await produtoMargemController.atualize(produtoMargemModelGlobal);
        return;
      }

      await produtoMargemController.crie(produtoMargemModelGlobal);
    }
  }

  Future<void> mensagemErroMargemErrada() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Margem superior a 100.00%, insira margem menor!'),
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
  Widget build(BuildContext context) {
    //Map
    var lista = FutureBuilder(
        future: listaProdutos,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProdutoCategoriaModel>?> snapshot) {
          if (snapshot.hasData) {
            final listaProdutos = snapshot.data!.map((produtoCategoriaModel) {
              return Column(
                children: [
                  cardProduto(produtoCategoriaModel.produto,
                      produtoCategoriaModel.categoriaModel),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            });

            return Column(
              children: [
                ...listaProdutos,
              ],
            );
          } else if (snapshot.hasError) {
            // If something went wrong
            return Text('Falha ao obter os dados...');
          }
          return CircularProgressIndicator();
        });

    final layoutVertical = Container(
      child: Column(
        children: [
          SubMenuComponent(
              titulo: 'Precificação',
              tituloPrimeiraRota: 'Margem',
              primeiraRota: '/cadastrar_margem',
              tituloSegundaRota: '',
              segundaRota: ''),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  MolduraComponent(
                    label: 'Produto',
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
              titulo: 'Precificação',
              tituloPrimeiraRota: 'Margem',
              primeiraRota: '/cadastrar_margem',
              tituloSegundaRota: '',
              segundaRota: ''),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: MolduraComponent(
                    label: 'Produto',
                    content: lista,
                  ),
                ))
              ],
            ),
          ))
        ],
      ),
    );

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: LayoutBuilder(builder: (context, constraint) {
          if (constraint.maxHeight > 600) {
            return layoutVertical;
          } else {
            return layoutHorizontal;
          }
        }));
  }

  //Lista de produtos
  Widget cardProduto(ProdutoModel produtoModel, CategoriaModel categoriaModel) {
    var margem =
        (produtoModel.valorVenda * 100 / produtoModel.valorCompra) - 100;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 340.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(235, 231, 231, 1),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextComponent(
                      label: 'ID Produto: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Text(produtoModel.id.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'Nome: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Expanded(child: Text(produtoModel.nome.toString()))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'Descrição: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Expanded(child: Text(produtoModel.descricao ?? ""))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: 'Categoria: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Expanded(child: Text(categoriaModel.nome))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      label: 'Valor\nCompra: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Text(valorCompraController.text =
                        formatter.format(produtoModel.valorCompra)),
                    TextComponent(
                      label: 'Valor\nVenda: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Text(valorVendaController.text =
                        formatter.format(produtoModel.valorVenda))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      label: 'Margem: ',
                      fontWeight: FontWeight.w700,
                    ),
                    Expanded(child: Text(margem.toStringAsPrecision(4) + '%')),
                    Container(
                        width: 150,
                        height: 30,
                        margin: EdgeInsets.only(top: 18, bottom: 13),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(0, 94, 181, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ))),
                          onPressed: () {
                            produtoModelGlobal = produtoModel;
                            produtoMargemModelGlobal = produtoMargemModelGlobal;
                            setState(() {});

                            margemController.text =
                                margem.toStringAsPrecision(4);
                            _abrirDialog(context);
                          },
                          child: TextComponent(
                            label: 'Alterar Margem',
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
