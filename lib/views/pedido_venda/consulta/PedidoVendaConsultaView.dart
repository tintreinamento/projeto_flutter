import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';

import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

class PedidoVendaConsultaView extends StatefulWidget {
  @override
  _PedidoVendaConsultaViewState createState() =>
      _PedidoVendaConsultaViewState();
}

class _PedidoVendaConsultaViewState extends State<PedidoVendaConsultaView> {
  bool _active = false;

  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  //Pedido
  PedidoModel? pedidoModel;

  consultarPedido() async {
    // PedidoController pedidoController = new PedidoController();
    // // pedidoModel = await pedidoController.obtenhaPorId(idPedidoController.text);
    // // print(pedidoModel!.itemPedido![0].produto!.nome);
    // List<ItemPedidoModel> listaDeItens = <ItemPedidoModel>[];
    // ItemPedidoModel item = new ItemPedidoModel();
    // pedidoModel = new PedidoModel(
    //   id: 1,
    //   dataPedido: '2021-06-19',
    //   totalPedido: 2.300,
    //   cliente: new ClienteModel(
    //       nome: 'Vítor',
    //       cpfCnpj: '04299121104',
    //       dataNascimento: '1999-09-17',
    //       estadoCivil: '1',
    //       email: 'vitor@gmail.com',
    //       sexo: '1',
    //       telefone: '62991216763'),
    //   funcionario: new FuncionarioModel(
    //     nome: 'Teste',
    //     cpfCnpj: '3273628136',
    //   ),
    // );
    _active = !_active;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<ItemPedido>? listaItemPedido = [];

    // if (pedidoModel != null) {
    //   listaItemPedido = pedidoModel!.itemPedido!.map((itemPedido) {
    //     return ItemPedido(
    //       itemPedidoModel: itemPedido,
    //     );
    //   }).toList();
    // }

    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        child: Column(children: [
          SubMenuComponent(
              titulo: 'Pedido Venda',
              tituloPrimeiraRota: 'Cadastrar',
              primeiraRota: '/pedido_venda_cadastrar',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/pedido_venda_consultar'),
          Expanded(
            child: Container(
                padding: paddingPadrao,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormConsulta(
                        formKeyConsultar: formkeyConsulta,
                        idPedidoController: idPedidoController,
                        onPressed: consultarPedido,
                      ),
                      if (_active)
                        DetalhePedido(
                            // pedidoModel: pedidoModel,
                            ),
                      if (_active) ItemPedido(),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}

class FormConsulta extends StatelessWidget {
  GlobalKey<FormState>? formKeyConsultar;
  Function? onPressed;
  TextEditingController? idPedidoController;

  FormConsulta(
      {this.formKeyConsultar, this.idPedidoController, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKeyConsultar,
        child: MolduraComponent(
            label: 'PEDIDO',
            content: Column(
              children: [
                InputComponent(
                  label: 'ID Pedido:',
                  controller: idPedidoController,
                ),
                ButtonComponent(
                  label: 'Consultar',
                  onPressed: onPressed,
                )
              ],
            )),
      ),
    );
  }
}

class DetalhePedido extends StatelessWidget {
  DetalhePedido({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MolduraComponent(
          label: 'DETALHE',
          content: Column(
            children: [
              InputComponent(
                label: 'Funcionário:',
              ),
              InputComponent(
                label: 'Cliente:',
              ),
              InputComponent(
                label: 'Data do pedido:',
              ),
              InputComponent(
                label: 'Valor do pedido:',
              ),
            ],
          )),
    );
  }
}

class ItemPedido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ItemPedidoCard> listaItemPedidoCard = [];

    for (int i = 0; i < 10; i++) {
      listaItemPedidoCard.add(ItemPedidoCard());
    }

    return Container(
      child: MolduraComponent(
        label: 'ITENS PEDIDO',
        content: Column(
          children: [...listaItemPedidoCard],
        ),
      ),
    );
  }
}

class ItemPedidoCard extends StatelessWidget {
  ItemPedidoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: MediaQuery.of(context).size.height * .1,
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: paddingPadrao,
                  color: colorCinza,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextComponent(
                            label: 'Nome: ',
                            fontWeight: FontWeight.bold,
                          ),
                          TextComponent(
                            label: 'Produto x ',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextComponent(
                            label: 'Categoria: ',
                            fontWeight: FontWeight.bold,
                          ),
                          TextComponent(
                            label: 'Categoria y',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextComponent(
                            label: 'Valor Compra: ',
                            fontWeight: FontWeight.bold,
                          ),
                          TextComponent(
                            label: '1000,00',
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
                child: Container(
              padding: paddingPadrao,
              color: colorBranco,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextComponent(
                    fontWeight: FontWeight.bold,
                    label: '3',
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
