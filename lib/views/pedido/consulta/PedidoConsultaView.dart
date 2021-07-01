import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';

import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

class PedidoConsultaView extends StatefulWidget {
  @override
  _PedidoConsultaViewState createState() => _PedidoConsultaViewState();
}

class _PedidoConsultaViewState extends State<PedidoConsultaView> {
  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  //Pedido
  PedidoModel? pedidoModel;

  consultarPedido() async {
    PedidoController pedidoController = new PedidoController();
    // pedidoModel = await pedidoController.obtenhaPorId(idPedidoController.text);
    // print(pedidoModel!.itemPedido![0].produto!.nome);
    List<ItemPedidoModel> listaDeItens = <ItemPedidoModel>[];
    ItemPedidoModel item = new ItemPedidoModel();
    pedidoModel = new PedidoModel(
      id: 1,
      dataPedido: '2021-06-19',
      totalPedido: 2.300,
      cliente: new ClienteModel(
          nome: 'Vítor',
          cpfCnpj: '04299121104',
          dataNascimento: '1999-09-17',
          estadoCivil: '1',
          email: 'vitor@gmail.com',
          sexo: '1',
          telefone: '62991216763'),
      funcionario: new FuncionarioModel(
        nome: 'Teste',
        cpfCnpj: '3273628136',
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<ItemPedido>? listaItemPedido = [];

    if (pedidoModel != null) {
      listaItemPedido = pedidoModel!.itemPedido!.map((itemPedido) {
        return ItemPedido(
          itemPedidoModel: itemPedido,
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          FormConsulta(
            formKeyConsultar: formkeyConsulta,
            idPedidoController: idPedidoController,
            onPressed: consultarPedido,
          ),
          if (pedidoModel != null)
            MolduraComponent(
              label: 'Detalhe',
              content: DetalhePedido(
                pedidoModel: pedidoModel,
              ),
            ),
          if (pedidoModel != null)
            MolduraComponent(
              label: 'Itens pedido',
              content: Column(
                children: [...listaItemPedido],
              ),
            ),
        ]),
      ),
    );
  }
}

class DetalhePedido extends StatelessWidget {
  PedidoModel? pedidoModel;
  DetalhePedido({
    Key? key,
    this.pedidoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              TextComponent(
                label: 'Funcionário: ',
              ),
              TextComponent(label: pedidoModel!.funcionario!.nome)
            ],
          ),
          Row(
            children: [
              TextComponent(
                label: 'Cliente: ',
              ),
              TextComponent(label: pedidoModel!.cliente!.nome)
            ],
          ),
          Row(
            children: [
              TextComponent(
                label: 'Data do Pedido: ',
              ),
              TextComponent(label: pedidoModel!.dataPedido)
            ],
          ),
          Row(
            children: [
              TextComponent(
                label: 'Valor do Pedido: ',
              ),
              TextComponent(label: pedidoModel!.totalPedido)
            ],
          )
        ],
      ),
    );
  }
}

class ItemPedido extends StatelessWidget {
  ItemPedidoModel? itemPedidoModel;

  ItemPedido({
    Key? key,
    this.itemPedidoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: paddingPadrao,
                  color: colorCinza,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextComponent(
                            label: 'Nome:',
                          ),
                          TextComponent(
                            label: itemPedidoModel!.produto!.nome,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextComponent(
                            label: 'Categoria:',
                          ),
                          TextComponent(
                            label: itemPedidoModel!.produto!.categoria,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextComponent(
                            label: 'Valor Compra:',
                          ),
                          TextComponent(
                            label: itemPedidoModel!.produto!.precoCompra,
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
                children: [
                  TextComponent(
                    label: itemPedidoModel!.quantidade,
                  ),
                ],
              ),
            )),
          ],
        ));
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
          child: Column(
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
    );
  }
}
