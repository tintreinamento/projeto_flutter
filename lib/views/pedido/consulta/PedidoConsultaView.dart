import 'package:flutter/material.dart';

import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
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
    pedidoModel = await pedidoController.obtenhaPorId(idPedidoController.text);
    print(pedidoModel!.itemPedido![0].produto!.nome);

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
      body: Container(
        child: Column(children: [
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
                label: 'Cliente: ',
              ),
              TextComponent(label: pedidoModel!.cliente!.nome)
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
                            label: 'Descrição:',
                          ),
                          TextComponent(
                            label: itemPedidoModel!.produto!.descricao,
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
