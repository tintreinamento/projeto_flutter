import 'package:flutter/material.dart';
import '../../models/produto.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../componentes/inputdecoration.dart';

import '../../componentes/textstyle.dart';

import '../../componentes/boxdecoration.dart';

import '../pedido/pedido.dart';

class BuscarProduto extends StatefulWidget {
  List<ProdutoModels> listaProduto = [];
  Function handleAdicionarProduto;
  Function handleRemoveProduto;

  BuscarProduto(
      {Key? key,
      required this.handleAdicionarProduto,
      required this.handleRemoveProduto})
      : super(key: key);

  @override
  _BuscarProdutoState createState() => _BuscarProdutoState();
}

class _BuscarProdutoState extends State<BuscarProduto> {
  final buscaController = TextEditingController();

  handleOnChangeBusca() {
    //Ordena
    /*widget.listaProduto.sort((a, b) {
      return b
          .getNome()
          .toLowerCase()
          .compareTo(buscaController.text.toLowerCase());
    });*/

    // widget.listaProduto = widget.listaProduto.where((produto) => produto.nome.startsWith(busca));

    //Atualiza o estado
    setState(() {});
  }

  handleOnPressedAdicionarProduto(ProdutoModels produtoModel) {
    widget.handleAdicionarProduto(produtoModel);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    ProdutoModels produtoModels1 = new ProdutoModels(1, 'x', 10.0, 100);
    ProdutoModels produtoModels2 = new ProdutoModels(2, 'Produto2', 10.0, 100);
    ProdutoModels produtoModels3 = new ProdutoModels(3, 'Praduto2', 10.0, 100);

    widget.listaProduto.add(produtoModels2);
    widget.listaProduto.add(produtoModels3);
    widget.listaProduto.add(produtoModels1);
  }

  @override
  Widget build(BuildContext context) {
    //Ordena
    print(buscaController.text);

    final listaProdutoOrdenada = widget.listaProduto.where((element) => element
        .getNome()
        .toLowerCase()
        .startsWith(buscaController.text.toLowerCase()));

    final auxListaProduto = listaProdutoOrdenada.map((produto) {
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
                  padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  color: Color.fromRGBO(235, 231, 231, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome: '),
                      Text('Categoria: '),
                      Text('Valor Venda: '),
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
                        child: Text('Qu'),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(8, 201, 62, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ))),
                                onPressed: () {
                                  produto.adicionaQuantidade(1);
                                  print(produto.getIdProduto());
                                  widget.handleAdicionarProduto(produto);
                                  setState(() {});
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1),
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
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(206, 5, 5, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ))),
                                onPressed: () {},
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      decoration: inputDecorationComponente,
                    ),
                  )
                ],
              ),
              ...auxListaProduto
            ],
          ),
        ));
  }
}
