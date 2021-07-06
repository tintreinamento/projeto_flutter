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
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/controllers/FuncionarioController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class PedidoCompraConsultaView extends StatefulWidget {
  @override
  _PedidoCompraConsultaViewState createState() =>
      _PedidoCompraConsultaViewState();
}

class _PedidoCompraConsultaViewState extends State<PedidoCompraConsultaView> {
  bool _active = false;

  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  //Pedido
  PedidoModel? pedidoModel;

  consultarPedido() async {
    PedidoController pedidoController = new PedidoController();

    pedidoModel =
        await pedidoController.obtenhaPorId(int.parse(idPedidoController.text));

    _active = !_active;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        child: Column(children: [
          SubMenuComponent(
              titulo: 'Pedido Compra',
              tituloPrimeiraRota: 'Cadastrar',
              primeiraRota: '/pedido_compra_cadastrar',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/pedido_compra_consultar'),
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
  TextEditingController fornecedorController = new TextEditingController();
  TextEditingController dataController = new TextEditingController();
  TextEditingController valorController = new TextEditingController();

  DetalhePedido({Key? key, this.pedidoModel}) : super(key: key);

  getfornecedor(value) async {
    FornecedorController fornecedor = new FornecedorController();
    final fornecedorModel = fornecedor.obtenhaPorId(value);

    fornecedorModel.then((value) {
      fornecedorController.text = value.nome;
    });
  }

  getFuncionario(value) async {
    FuncionarioController funcionario = new FuncionarioController();
    final funcionarioModel = funcionario.obtenhaPorId(value);

    funcionarioModel.then((value) {
      funcionarioController.text = value.nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

    getFuncionario(pedidoModel!.idFuncionario);
    getfornecedor(pedidoModel!.data);

    print(fornecedorController.text);

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
                label: 'Fornecedor:',
                controller: fornecedorController,
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

class fornecedorController {}

class ItemPedido extends StatefulWidget {
  PedidoModel? pedidoModel;

  ItemPedido({Key? key, this.pedidoModel}) : super(key: key);

  @override
  _ItemPedidoState createState() => _ItemPedidoState(pedidoModel);
}

class _ItemPedidoState extends State<ItemPedido> {
  var listaItemPedido = new List.empty(growable: true);
  PedidoModel? pedidoModel;
  ProdutoModel? produtoModel;
  CategoriaModel? categoriaModel;

  _ItemPedidoState(PedidoModel? pedidoModel) {
    this.pedidoModel = pedidoModel;
  }

  getItemPedidos() async {
    ItemPedidoController itemPedidoController = new ItemPedidoController();
    listaItemPedido = await itemPedidoController.obtenhaTodos();

    listaItemPedido = listaItemPedido.map((element) {
      if (element.idPedido == pedidoModel?.id) {
        return element;
      }
    }).toList();

    listaItemPedido.removeWhere((element) => element == null);

    produtoModel = (await new ProdutoController()
        .obtenhaPorId(listaItemPedido.first.idProduto));

    categoriaModel = (await new CategoriaController()
        .obtenhaPorId(produtoModel?.idCategoria));

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getItemPedidos();
  }

  @override
  Widget build(BuildContext context) {
    //1
    listaItemPedido = listaItemPedido.where((element) {
      return element.idPedido == widget.pedidoModel!.id;
    }).toList();
    //2
    final listaItemPedidoCard = listaItemPedido.map((element) {
      return ItemPedidoCard(
          itemPedidoModel: element,
          produtoModel: this.produtoModel,
          categoriaModel: this.categoriaModel);
    }).toList();

    return Container(
      child: MolduraComponent(
        label: 'PRODUTO',
        content: Column(
          children: [...listaItemPedidoCard],
        ),
      ),
    );
  }
}

class ItemPedidoCard extends StatelessWidget {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  ItemPedidoModel? itemPedidoModel;

  ProdutoModel? produtoModel;
  CategoriaModel? categoriaModel;

  ItemPedidoCard(
      {Key? key, this.itemPedidoModel, this.produtoModel, this.categoriaModel})
      : super(key: key);

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextComponent(
                            label: 'Nome: ',
                            fontWeight: FontWeight.bold,
                          ),
                          TextComponent(
                            label: produtoModel?.nome,
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
                            label: categoriaModel?.nome,
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
                            label:
                                formatter.format(itemPedidoModel!.valorTotal),
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
