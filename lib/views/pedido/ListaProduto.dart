import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/Responsive.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/util/CarrinhoCompra.dart';
import 'package:provider/provider.dart';

class ListaProduto extends StatefulWidget {
  List<ItemPedidoModel> itemPedido = [];

  ListaProduto({Key? key}) : super(key: key);

  @override
  _ListaProdutoState createState() => _ListaProdutoState();
}

class _ListaProdutoState extends State<ListaProduto> {
  ProdutoController produtoController = new ProdutoController();
  late Future<List<ProdutoModel>> listaProdutos;
  String parametroNomeProduto = '';

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  void carregarProdutos() async {
    listaProdutos = produtoController.obtenhaTodos();
  }

  onChangeNomeProduto(String nomeProduto) {
    setState(() {
      parametroNomeProduto = nomeProduto;
    });
  }

  addProduto(produto) {
    widget.itemPedido.add(produto);
  }

  removeProduto(produto) {
    widget.itemPedido.remove(produto);
  }

  @override
  Widget build(BuildContext context) {
    var layoutListaProduto;
    var size = MediaQuery.of(context).size;

    if (ResponsiveComponent.isMobile(context)) {
      layoutListaProduto = FutureBuilder(
          future: listaProdutos,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProdutoModel>> snapshot) {
            if (snapshot.hasData) {
              //Ordenar os produtos
              final listaProdutoOrdenada = snapshot.data!.where((produto) {
                return produto.nome
                    .toLowerCase()
                    .startsWith(parametroNomeProduto.toString());
              });

              var listaProdutoWidget = listaProdutoOrdenada.map((produto) {
                return SizedBox(
                  width: size.width,
                  height: size.height * 0.30,
                  child: ProdutoCard(produto: produto),
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...listaProdutoWidget,
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // If something went wrong
              return Text('Falha ao obter os dados da API');
            }
            // While fetching, show a loading spinner.
            return CircularProgressIndicator();
          });
    }

    if (ResponsiveComponent.isTablet(context)) {
      layoutListaProduto = FutureBuilder(
          future: listaProdutos,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProdutoModel>> snapshot) {
            if (snapshot.hasData) {
              List<Row> listaProdutoWidget = [];

              final listaProdutoOrdenada = snapshot.data!.where((produto) {
                return produto.nome
                    .toLowerCase()
                    .startsWith(parametroNomeProduto.toString());
              });

              var listaProdutos = listaProdutoOrdenada.toList();

              //loop
              for (int i = 0; i + 1 < listaProdutos.length; i++) {
                listaProdutoWidget.add(Row(
                  children: [
                    SizedBox(
                      width: size.width / 2 - 20,
                      height: size.height * 0.30,
                      child: ProdutoCard(produto: listaProdutos[i]),
                    ),
                  ],
                ));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...listaProdutoWidget,
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // If something went wrong
              return Text('Falha ao obter os dados da API');
            }
            // While fetching, show a loading spinner.
            return CircularProgressIndicator();
          });
    }

    if (ResponsiveComponent.isDesktop(context)) {
      layoutListaProduto = FutureBuilder(
          future: listaProdutos,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProdutoModel>> snapshot) {
            if (snapshot.hasData) {
              List<Row> listaProdutoWidget = [];

              final listaProdutoOrdenada = snapshot.data!.where((produto) {
                return produto.nome
                    .toLowerCase()
                    .startsWith(parametroNomeProduto.toString());
              });

              var listaProdutos = listaProdutoOrdenada.toList();

              //loop
              for (int i = 0; i + 1 < listaProdutos.length; i++) {
                listaProdutoWidget.add(Row(
                  children: [
                    SizedBox(
                      width: size.width / 3 - 20,
                      height: size.height * 0.30,
                      child: ProdutoCard(produto: listaProdutos[i]),
                    ),
                    SizedBox(
                      width: size.width / 3 - 20,
                      height: size.height * 0.30,
                      child: ProdutoCard(produto: listaProdutos[i + 1]),
                    ),
                    SizedBox(
                      width: size.width / 3 - 20,
                      height: size.height * 0.30,
                      child: ProdutoCard(produto: listaProdutos[i + 1]),
                    ),
                  ],
                ));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...listaProdutoWidget,
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // If something went wrong
              return Text('Falha ao obter os dados da API');
            }
            // While fetching, show a loading spinner.
            return CircularProgressIndicator();
          });
    }

    return Container(
      width: size.height,
      margin: marginPadrao,
      child: FormComponent(
        label: 'Produtos',
        content: Column(
          children: [
            Expanded(
                child: FormBuscarProduto(
              onChanged: onChangeNomeProduto,
            )),
            Expanded(
              flex: 8,
              child: layoutListaProduto,
            )
          ],
        ),
      ),
    );
  }
}

class ProdutoCard extends StatelessWidget {
  ProdutoModel produto;

  ProdutoCard({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Container(
      padding: paddingPadrao,
      margin: marginPadrao,
      color: colorCinza,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Nome: '),
                        TextComponent(label: produto.nome),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Categoria: '),
                        TextComponent(label: produto.nome),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Preço: '),
                        TextComponent(label: produto.valorVenda.toString()),
                      ],
                    ),
                  )
                ]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      TextComponent(
                        label: context
                            .read<CarrinhoCompra>()
                            .getQuantidade(produto)
                            .toString(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonAddCustom(
                          label: '+',
                          backgroundColor: colorVerde,
                          produto: produto,
                        ),
                      ),
                      Expanded(
                        child: ButtonRemoveCustom(
                          label: '-',
                          backgroundColor: colorVermelho,
                          produto: produto,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonAddCustom extends StatelessWidget {
  var label;
  var backgroundColor;
  ProdutoModel produto;

  ButtonAddCustom(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.produto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ))),
          onPressed: () {
            context.read<CarrinhoCompra>().addItemCarrinho(produto);
          },
          child: TextComponent(label: label)),
    );
  }
}

class ButtonRemoveCustom extends StatelessWidget {
  var label;
  var backgroundColor;
  ProdutoModel produto;

  ButtonRemoveCustom(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.produto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ))),
          onPressed: () {
            context.read<CarrinhoCompra>().removeItemCarrinho(produto);
          },
          child: TextComponent(label: label)),
    );
  }
}

class FormBuscarProduto extends StatelessWidget {
  Function? onChanged;

  FormBuscarProduto({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: InputComponent(
            label: 'Produto',
            onChange: onChanged,
          ),
        )
      ],
    );
  }
}
