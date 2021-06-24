import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class ProdutoConsultarView extends StatefulWidget {
  const ProdutoConsultarView({Key? key}) : super(key: key);

  @override
  _ProdutoConsultarViewState createState() => _ProdutoConsultarViewState();
}

class _ProdutoConsultarViewState extends State<ProdutoConsultarView> {
  final _formKeyConsultaProduto = GlobalKey<FormState>();
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
    if (_formKeyConsultaProduto.currentState!.validate()) {
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
                return 'Campo Nome vazio!';
              }
              return null;
            },
          ),
          ButtonComponent(
            label: 'Consultar',
            onPressed: consultarProduto,
          )
        ],
      ),
    );

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
            return Text('Falha ao obter os dados da API ');
          }
          return CircularProgressIndicator();
        });

    final layoutVertical = Container(
      child: Column(
        children: [
          SubMenuComponent(
              titulo: 'Produto',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/consulta_cliente',
              tituloSegundaRota: 'Consulta',
              segundaRota: '/consulta_cliente'),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  FormComponent(
                    label: 'Consulta',
                    content: formConsulta,
                  ),
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
              titulo: 'Produto',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/consulta_cliente',
              tituloSegundaRota: 'Consulta',
              segundaRota: '/consulta_cliente'),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormComponent(
                    label: 'Produto',
                    content: formConsulta,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: FormComponent(
                    label: 'Produtos',
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
                  children: [
                    TextComponent(label: 'Nome: '),
                    Text(produtoModel.nome)
                  ],
                ),
                Row(
                  children: [
                    TextComponent(label: 'Descrição: '),
                    Text(produtoModel.descricao)
                  ],
                ),
                Row(
                  children: [
                    TextComponent(label: 'Categoria: '),
                    Text(produtoModel.idCategoria.toString())
                  ],
                ),
                Row(
                  children: [
                    TextComponent(label: 'Valor Compra: '),
                    Text(produtoModel.valorCompra.toString())
                  ],
                ),
                Row(
                  children: [
                    TextComponent(label: 'Valor Venda: '),
                    Text(produtoModel.valorVenda.toString())
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
