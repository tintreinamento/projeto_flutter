import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
//import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
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
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(label: 'ID Produto: '),
                    TextComponent(label: 'Produto: ')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(produtoModel.id.toString()),
                    Expanded(child: Text('produto'))
                    //Expanded(child: Text(produtoModel.nome))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(label: 'Margem: '),
                    TextComponent(label: 'Valor Compra: '),
                    TextComponent(label: 'Valor Venda: '),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(produtoMargemModel.margem.toString()),
                    Text(produtoModel.valorCompra.toString()),
                    Text(produtoModel.valorVenda.toString())
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              ButtonComponent(
                  label: 'Cadastrar',
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); //Navigator.pop(context, 'Cadastrar'),
                  }),
            ],
          );
        });
  }

/* 
  boxMargem() async {
    ProdutoModel produtoModel = new ProdutoModel();
    ProdutoMargemModel produtoMargemModel = new ProdutoMargemModel();
    //aqui tem que abrir aquela telinha pra cadastrar a margem
    // configura o button
    var okButton = TextButton(onPressed: () {}, child: Text("OK"));
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: const Text(''),
      content: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(label: 'ID Produto: '),
                  TextComponent(label: 'Produto: ')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(produtoModel.id.toString()),
                  Expanded(child: Text('produto'))
                  //Expanded(child: Text(produtoModel.nome))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextComponent(label: 'Margem: '),
                  TextComponent(label: 'Valor Compra: '),
                  TextComponent(label: 'Valor Venda: '),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(produtoMargemModel.margem.toString()),
                  Text(produtoModel.valorCompra.toString()),
                  Text(produtoModel.valorVenda.toString())
                ],
              ),
            ])
          ])),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }


  Future<void> _showMyDialog() async {
    ProdutoModel produtoModel = new ProdutoModel();
    ProdutoMargemModel produtoMargemModel = new ProdutoMargemModel();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Stack(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(label: 'ID Produto: '),
                      TextComponent(label: 'Produto: ')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(produtoModel.id.toString()),
                      Expanded(child: Text('produto'))
                      //Expanded(child: Text(produtoModel.nome))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(label: 'Margem: '),
                      TextComponent(label: 'Valor Compra: '),
                      TextComponent(label: 'Valor Venda: '),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(produtoMargemModel.margem.toString()),
                      Text(produtoModel.valorCompra.toString()),
                      Text(produtoModel.valorVenda.toString())
                    ],
                  ),
                ])
              ])),
          actions: <Widget>[
            ButtonComponent(
              label: 'Cadastrar',
              onPressed: () => Navigator.pop(context, 'Cadastrar'),
            ),
          ],
        );
      },
    );
  }
*/
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
                  FormComponent(
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
                  child: FormComponent(
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
                    Expanded(child: Text(produtoModel.nome))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(label: 'Descrição: '),
                    Expanded(child: Text(produtoModel.descricao))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(label: 'Categoria: '),
                    Expanded(child: Text(produtoModel.idCategoria.toString()))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(label: 'Valor Compra: '),
                    Text(produtoModel.valorCompra.toString()),
                    TextComponent(label: 'Valor Venda: '),
                    Text(produtoModel.valorVenda.toString())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(label: 'Margem: '),
                    Text(produtoMargemModel.margem.toString()),
                    ButtonComponent(
                      label: 'Alterar Margem',
                      onPressed: () {
                        _abrirDialog(context);
                      } /*boxMargem() _showMyDialog()*/,
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
