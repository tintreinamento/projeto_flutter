import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ProdutoMargemModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class PrecificacaoView extends StatefulWidget {
  const PrecificacaoView({Key? key}) : super(key: key);

  @override
  _PrecificacaoViewState createState() => _PrecificacaoViewState();
}

class _PrecificacaoViewState extends State<PrecificacaoView> {
  final _formKeyPrecificacao = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  ProdutoController produtoController = new ProdutoController();

  late Future<List<ProdutoModel>> listaProdutos;

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
    listaProdutos = produtoController.obtenhaTodos();
  }

  Future<void> _abrirDialog(BuildContext context) async {
    ProdutoModel produtoModel = new ProdutoModel();
    ProdutoMargemModel produtoMargemModel = new ProdutoMargemModel();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(label: 'ID Produto:\n'),
                      TextComponent(label: 'Produto:\n')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(produtoModel.id.toString() + '\n'),
                      Text(produtoModel.nome.toString() + '\n')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(label: 'Margem:\n'),
                      TextComponent(label: 'Valor\nCompra:\n'),
                      TextComponent(label: 'Valor\nVenda:\n'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(produtoMargemModel.margem.toString() + '\n'),
                      Text(produtoModel.valorCompra.toString() + '\n'),
                      Text(produtoModel.valorVenda.toString() + '\n')
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ButtonComponent(
                  label: 'Cadastrar',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Map
    var lista = FutureBuilder(
        future: listaProdutos,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
          if (snapshot.hasData) {
            final listaProdutos = snapshot.data!.map((cliente) {
              return Column(
                children: [
                  cardProduto(cliente),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }).toList();

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

  Widget cardProduto(ProdutoModel produtoModel) {
    ProdutoMargemModel produtoMargemModel = new ProdutoMargemModel();

    TextEditingController valorCompraController = new TextEditingController();
    TextEditingController valorVendaController = new TextEditingController();
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

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
                    TextComponent(label: 'ID Produto: '),
                    Text(produtoModel.id.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(label: 'Nome: '),
                    Expanded(child: Text(produtoModel.nome.toString()))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(label: 'Descrição: '),
                    Expanded(child: Text(produtoModel.descricao ?? ""))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(label: 'Categoria: '),
                    Expanded(child: Text(produtoModel.id.toString()))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      label: 'Valor\nCompra: ',
                    ),
                    Text(valorCompraController.text =
                        formatter.format(produtoModel.valorCompra)),
                    TextComponent(label: 'Valor\nVenda: '),
                    Text(valorVendaController.text =
                        formatter.format(produtoModel.valorVenda))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(label: 'Margem: '),
                    Expanded(child: Text(produtoMargemModel.margem ?? "")),
                    ButtonComponent(
                      label: 'Alterar Margem',
                      onPressed: () {
                        _abrirDialog(context);
                      },
                    )
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
