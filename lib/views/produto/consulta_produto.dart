import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class ProdutoConsultarView extends StatefulWidget {
  const ProdutoConsultarView({Key? key}) : super(key: key);

  @override
  _ProdutoConsultarViewState createState() => _ProdutoConsultarViewState();
}

class _ProdutoConsultarViewState extends State<ProdutoConsultarView> {
  final _formKeyConsultaProduto = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final idProdutoController = TextEditingController();

  ProdutoController produtoController = new ProdutoController();
  CategoriaController categoriaController = new CategoriaController();

  TextEditingController valorCompraController = new TextEditingController();
  TextEditingController valorVendaController = new TextEditingController();
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  late Future<List<ProdutoModel>> listaProdutos;

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarProduto() {
    if (_formKeyConsultaProduto.currentState!.validate()) {
      produtoController
          .obtenhaPorNome(nomeController.text.toString())
          .then((value) => listaProdutos);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    listaProdutos = produtoController.obtenhaTodos();
  }

  @override
  Widget build(BuildContext context) {
    final formConsulta = Form(
      key: _formKeyConsultaProduto,
      child: Column(
        children: [
          InputComponent(
            label: 'Nome: ',
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
            onPressed: consultarProduto,
          ),
        ],
      ),
    );

    //Map
    var lista = FutureBuilder(
        future: listaProdutos,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
          if (snapshot.hasData) {
            final listaOrdenada = snapshot.data!.where((produto) {
              return produto.nome!
                  .toLowerCase()
                  .startsWith(nomeController.text.toLowerCase());
            });

            final listaProdutos = listaOrdenada.map((produto) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    cardProduto(produto),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
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
              titulo: 'Produto',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/cadastrar_produto',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/consultar_produto'),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  MolduraComponent(
                    label: 'Consulta',
                    content: formConsulta,
                  ),
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
              titulo: 'Produto',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/cadastrar_produto',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/consultar_produto'),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MolduraComponent(
                    label: 'Consulta',
                    content: formConsulta,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
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
    CategoriaModel categoriaModel = new CategoriaModel();

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
                    Expanded(child: Text(produtoModel.descricao ?? ""))
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
                  children: [
                    TextComponent(label: 'Valor Compra: '),
                    Text(valorCompraController.text =
                        formatter.format(produtoModel.valorCompra))
                  ],
                ),
                Row(
                  children: [
                    TextComponent(label: 'Valor Venda: '),
                    Text(valorCompraController.text =
                        formatter.format(produtoModel.valorVenda))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
