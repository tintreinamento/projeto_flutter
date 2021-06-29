import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

class PedidoConsultaView extends StatefulWidget {
  @override
  _PedidoConsultaViewState createState() => _PedidoConsultaViewState();
}

class _PedidoConsultaViewState extends State<PedidoConsultaView> {
  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  consultarPedido() async {
    

    PedidoController pedidoController = new PedidoController();
    PedidoModel pedidoModel = await 
        pedidoController.obtenhaPorId(idPedidoController.text);

    print(pedidoModel.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            FormConsulta(
              formKeyConsultar: formkeyConsulta,
              idPedidoController: idPedidoController,
              onPressed: consultarPedido,
            )
          ],
        ),
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
