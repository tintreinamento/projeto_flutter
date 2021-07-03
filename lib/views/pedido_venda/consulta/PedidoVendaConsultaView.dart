import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';

import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/FuncionarioController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
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
    PedidoController pedidoController = new PedidoController();

    pedidoModel =
        await pedidoController.obtenhaPorId(int.parse(idPedidoController.text));

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
                          pedidoModel: pedidoModel,
                          // pedidoModel: pedidoModel,
                        ),
                      if (_active)
                        ItemPedido(
                          pedidoModel: pedidoModel,
                        ),
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
  PedidoModel? pedidoModel;

  TextEditingController funcionarioController = new TextEditingController();
  TextEditingController clienteController = new TextEditingController();
  TextEditingController dataController = new TextEditingController();
  TextEditingController valorController = new TextEditingController();

  DetalhePedido({Key? key, this.pedidoModel}) : super(key: key);

  getCliente(value) async {
    ClienteController cliente = new ClienteController();
    final clienteModel = cliente.obtenhaPorId(value);

    clienteModel.then((value) {
      clienteController.text = value.nome;
    });

    //return clienteModel.then((value) => null);
  }

  getFuncionario(value) async {
    FuncionarioController funcionario = new FuncionarioController();
    final funcionarioModel = funcionario.obtenhaPorId(value);

    funcionarioModel.then((value) {
      funcionarioController.text = value.nome;
    });

    //return clienteModel.then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    // clienteController.text =
    //     getCliente(pedidoModel!.idCliente).then((value) {}) as String;

    getFuncionario(pedidoModel!.idFuncionario);
    getCliente(pedidoModel!.idCliente);

    print(clienteController.text);

    dataController.text = UtilData.obterDataDDMMAAAA(
        DateTime.parse(pedidoModel!.data.toString().substring(0, 10)));
    valorController.text = formatter.format(pedidoModel!.total);

    return Container(
      child: MolduraComponent(
          label: 'DETALHE',
          content: Column(
            children: [
              InputComponent(
                label: 'Funcionário:',
                controller: funcionarioController,
              ),
              InputComponent(
                label: 'Cliente:',
                controller: clienteController,
              ),
              InputComponent(
                label: 'Data do pedido:',
                controller: dataController,
              ),
              InputComponent(
                label: 'Valor do pedido:',
                controller: valorController,
              ),
            ],
          )),
    );
  }
}

class ItemPedido extends StatefulWidget {
  PedidoModel? pedidoModel;

  ItemPedido({Key? key, this.pedidoModel}) : super(key: key);

  @override
  _ItemPedidoState createState() => _ItemPedidoState();
}

class _ItemPedidoState extends State<ItemPedido> {
  List<ItemPedidoModel>? listaItemPedido;

  getItemPedidos() async {
    ItemPedidoController itemPedidoController = new ItemPedidoController();
    listaItemPedido = await itemPedidoController.obtenhaTodos();

    setState(() {});
  }

  // getSelecionaItemPedido(value) {

  //   //print(listaItemPedido![0].valorTotal);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getItemPedidos();
    //getSelecionaItemPedido(widget.pedidoModel!.id);
  }

  @override
  Widget build(BuildContext context) {
    //1
    listaItemPedido = listaItemPedido!.where((element) {
      return element.idPedido == widget.pedidoModel!.id;
    }).toList();
    //2
    final listaItemPedidoCard = listaItemPedido!.map((element) {
      return ItemPedidoCard(
        itemPedidoModel: element,
      );
    }).toList();

    // List<ItemPedidoCard> listaItemPedidoCard = [];

    // for (int i = 0; i < 10; i++) {
    //   listaItemPedidoCard.add(ItemPedidoCard());
    // }

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
  ItemPedidoModel? itemPedidoModel;
  ItemPedidoCard({Key? key, this.itemPedidoModel}) : super(key: key);

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
                            label: itemPedidoModel!.idProduto.toString(),
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
                            label: itemPedidoModel!.valorTotal.toString(),
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
                    label: itemPedidoModel!.quantidade.toString(),
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
