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

class EstoqueView extends StatefulWidget {
  @override
  _EstoqueViewState createState() =>
      _EstoqueViewState();
}

class _EstoqueViewState extends State<EstoqueView> {
  bool _active = false;

  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  //Pedido
  PedidoModel? pedidoModel;

  consultarPedido() async {
  
    _active = !_active;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<ItemPedido>? listaItemPedido = [];

    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        child: Column(children: [
          SubMenuComponent(
              titulo: 'Estoque',
              tituloPrimeiraRota: '',
              primeiraRota: '/estoque',
              tituloSegundaRota: '',
              segundaRota: ''),
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
                      if (_active) Buttons(),
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
            label: 'Buscar Produto',
            content: Column(
              children: [
                InputComponent(
                  label: 'Nome:',
                //  controller: idPedidoController,
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
          label: 'Produto',
          content: Column(
            children: [
              InputComponent(
                label: 'Nome:',
              ),
              InputComponent(
                label: 'CPF/CNPJ:',
              ),
              InputComponent(
                label: 'Telefone:',
              ),
              InputComponent(
                label: 'E-mail:',
              ),
            ],
          )),
    );
  }
}

class Buttons  extends StatelessWidget {
  GlobalKey<FormState>? formKeyCadastrar;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKeyCadastrar,
        child: (
             Column(
              children: [
                ButtonComponent(
                  label: 'Cadastrar Novo Estoque',
                //  controller: idPedidoController,
                ),
                ButtonComponent(
                  label: 'Atualizar',
                  onPressed: onPressed,
                )
              ],
            )),
      ),
      
    );
  }
}

class ItemPedido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ItemPedidoCard> listaItemPedidoCard = [];

    for (int i = 0; i < 5; i++) {
      listaItemPedidoCard.add(ItemPedidoCard());
    }

    return Container(
      child: MolduraComponent(
        label: 'Estoque',
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
        height: MediaQuery.of(context).size.height * .1,
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: paddingPadrao,
                  color:  colorCinza,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextComponent(
                            label: 'Filial 01 ',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                     
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
                    label: '50',
                  ),
                ],
              ),
            )),
          ],
        ));



  }
}
