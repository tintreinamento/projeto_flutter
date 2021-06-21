import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';

import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

class PedidoVendaConsultarView extends StatefulWidget {
  const PedidoVendaConsultarView({Key? key}) : super(key: key);

  @override
  _PedidoVendaConsultarViewState createState() =>
      _PedidoVendaConsultarViewState();
}

class _PedidoVendaConsultarViewState extends State<PedidoVendaConsultarView> {
  final _formKeyConsultaPedido = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nomeFuncionarioController = TextEditingController();
  final nomeClienteController = TextEditingController();
  final dataController = TextEditingController();
  final valorController = TextEditingController();

  ItemPedidoController itemPedidoController = new ItemPedidoController();
  PedidoController pedidoController = new PedidoController();
  late Future<List<ItemPedidoModel>> listaItemPedidos;
  late Future<List<PedidoModel>> buscaPedido;

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  consultarItensPedidos() {
    if (_formKeyConsultaPedido.currentState!.validate()) {
      //consulta
    }
  }

  @override
  void initState() {
    super.initState();
    listaItemPedidos = itemPedidoController.obtenhaTodos();
    //buscaPedido = pedidoController.obtenhaPorId();
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
            label: 'Funcionário:',
            controller: nomeFuncionarioController,
          ),
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

    //Map
    var lista = FutureBuilder(
        future: listaItemPedidos,
        builder: (BuildContext context,
            AsyncSnapshot<List<ItemPedidoModel>> snapshot) {
          if (snapshot.hasData) {
            final listaItemPedidos = snapshot.data!.map((itemPedido) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    cardPedido(itemPedido),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }).toList();

            return Column(
              children: [
                ...listaItemPedidos,
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
                  FormComponent(
                    label: 'Pedidos',
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
                      content: lista,
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

Widget cardPedido(ItemPedidoModel itemPedidoModel) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: 340.0),
    child: Row(children: [
      Container(
        padding: EdgeInsets.all(10),
        color: Color.fromRGBO(235, 231, 231, 1),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextComponent(
                      label: 'Nome: ',
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ]),
  );
}
