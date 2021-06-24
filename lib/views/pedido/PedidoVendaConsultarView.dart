import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';

import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

class PedidoVendaConsultarView extends StatefulWidget {
  const PedidoVendaConsultarView({Key? key}) : super(key: key);

  @override
  _PedidoVendaConsultarViewState createState() =>
      _PedidoVendaConsultarViewState();
}

class ProdutoModelLista {
  var nome;
  var valor;
  var categoria;
  var quantidade;

  ProdutoModelLista({this.nome, this.valor, this.categoria, this.quantidade});
}

class _PedidoVendaConsultarViewState extends State<PedidoVendaConsultarView> {
  final _formKeyConsultaPedido = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nomeFuncionarioController = TextEditingController();
  final nomeClienteController = TextEditingController();
  final dataController = TextEditingController();
  final valorController = TextEditingController();

  final List<ProdutoModelLista> produtosCard = new List.empty(growable: false);

  ItemPedidoController itemPedidoController = new ItemPedidoController();
  PedidoController pedidoController = new PedidoController();
  late Future<List<ProdutoModelLista>> listaItensPedidos;

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarItensPedidos() async {
    var pedido =
        await new PedidoController().obtenhaPorId(int.parse(idController.text));
    var cliente = await new ClienteController().obtenhaPorId(pedido.idCliente);
    setState(() {
      nomeClienteController.text = cliente.nome;
      dataController.text = pedido.data;
      valorController.text = pedido.total.toString();
    });

    //consulta
    var itemPedido = await new ItemPedidoController()
        .obtenhaTodosItensPedidosPorIdPedido(int.parse(idController.text));

    //produtosCard.clear();

    itemPedido.forEach((element) async {
      var produto =
          await new ProdutoController().obtenhaPorId(element.idProduto);
      var categoria =
          await new CategoriaController().obtenhaPorId(produto.idCategoria);

      var produtoModel = new ProdutoModelLista(
          nome: produto.nome,
          valor: produto.valorCompra,
          categoria: categoria.nome,
          quantidade: element.quantidade);
      produtosCard.add(produtoModel);
    });
    //listaItensPedidos = Future.value(produtosCard);
  }

  @override
  void initState() {
    super.initState();
    // buscaPedido = pedidoController().obtenhaPorId();
  }

  @override
  Widget build(BuildContext context) {
    final formConsulta = Form(
      child: Column(
        children: [
          InputComponent(
            label: 'ID pedido:',
            controller: idController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo id pedido vazio !';
              }
              return null;
            },
          ),
          ButtonComponent(
            label: 'Consultar',
            onPressed: consultarItensPedidos,
          ),
        ],
      ),
    );

    final formDetalhe = Form(
      child: Column(
        children: [
          InputComponent(
            label: 'Cliente:',
            controller: nomeClienteController,
          ),
          InputComponent(
            label: 'Data do Pedido:',
            controller: dataController,
          ),
          InputComponent(
            label: 'Valor do Pedido:',
            controller: valorController,
          ),
        ],
      ),
    );

    // //Map
    // var lista = ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     itemCount: produtosCard.length,
    //     itemBuilder: (context, index) {
    //       return Container(child: cardProduto(produtosCard[index]));
    //     });
    // final listaProdutos = produtosCard.map((produto) {
    //   return SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         cardProduto(produto),
    //         SizedBox(
    //           height: 10,
    //         ),
    //       ],
    //     ),
    //   );
    // }).toList();

    // return Column(
    //   children: [
    //     ...listaProdutos,
    //   ],
    // );

    final layoutVertical = Container(
      child: Column(
        children: [
          SubMenuComponent(
            titulo: 'Pedido Venda',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_pedido_venda',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_pedido_venda',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  FormComponent(
                    label: 'Pedido',
                    content: formConsulta,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FormComponent(
                    label: 'Detalhe',
                    content: formDetalhe,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: FormComponent(
                    label: 'Pedidos',
                    //content: lista,
                  )),
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
            titulo: 'Pedido Venda',
            tituloPrimeiraRota: 'Cadastro',
            primeiraRota: '/cadastrar_pedido_venda',
            tituloSegundaRota: 'Consultar',
            segundaRota: '/consultar_pedido_venda',
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FormComponent(
                      label: 'Pedido',
                      content: formConsulta,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FormComponent(
                    label: 'Detalhe',
                    content: formDetalhe,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: FormComponent(
                      label: 'Pedidos',
                      //content: lista,
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxHeight > 600) {
              return layoutVertical;
            } else {
              return layoutHorizontal;
            }
          },
        ));
  }
}

Widget cardProduto(ProdutoModelLista produto) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: 340.0),
    child: Row(children: [
      Container(
        padding: EdgeInsets.all(10),
        color: Color.fromRGBO(235, 231, 231, 1),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextComponent(
                    label: 'Nome: ',
                  ),
                  TextComponent(
                    label: produto.nome,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  TextComponent(
                    label: 'Categoria: ',
                  ),
                  TextComponent(
                    label: produto.categoria,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  TextComponent(
                    label: 'Valor Compra: ',
                  ),
                  TextComponent(
                    label: produto.valor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    produto.quantidade,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]),
  );
}
