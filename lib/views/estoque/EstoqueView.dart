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
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/EstoqueModel.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/views/pedido_compra/consulta/PedidoCompraConsultaView.dart';

class EstoqueView extends StatefulWidget {
  @override
  _EstoqueViewState createState() => _EstoqueViewState();
}

class _EstoqueViewState extends State<EstoqueView> {
  bool _active = false;
  Future<ProdutoModel>? produtoModel;

  GlobalKey<FormState> formkeyConsulta = GlobalKey<FormState>();

  TextEditingController idPedidoController = TextEditingController();

  // Pedido
  // EstoqueModel? estoqueModel;

  consultarEstoque() async {
    _active = !_active;
    setState(() {});
  }

  carregarProduto() {
    ProdutoController produtoController = new ProdutoController();
    produtoModel = produtoController.obtenhaPorId(152);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    carregarProduto();
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: consultarEstoque,
                      ),
                      FutureBuilder(
                          future: produtoModel,
                          builder: (BuildContext context,
                              AsyncSnapshot<ProdutoModel> snapshot) {
                            var children;
                            if (snapshot.hasData) {
                              children = [
                                DetalheProduto(
                                  produtoModel: snapshot.data,
                                ),
                                Estoque(produtoModel: snapshot.data),
                                Buttons()
                              ];
                            } else if (snapshot.hasError) {
                              children = TextComponent(
                                label: 'Error ao carregar produto !',
                              );
                            } else {
                              children = Container(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container(
                              child: Column(
                                children: [...children],
                              ),
                            );
                          }),
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
                  onPressed: _abrirDialog,
                )
              ],
            )),
      ),
    );
  }

  Future<void> _abrirDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: Container(
              height: MediaQuery.of(context).size.height * .3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    //flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID Produto:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Produto:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('produtoModelGlobal.id.toString()'),
                        Text('produtoModelGlobal.nome.toString()')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Valor Compra:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Valor Venda:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('valorCompraController.text = formatter.format(produtoModelGlobal.valorCompra)'),
                        Text('valorVendaController.text = formatter.format(produtoModelGlobal.valorVenda)'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              ButtonComponent(
                  label: 'Cadastrar',
                  onPressed: () async {
                    
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

class DetalheProduto extends StatefulWidget {
  ProdutoModel? produtoModel;

  DetalheProduto({Key? key, this.produtoModel}) : super(key: key);

  @override
  _DetalheProdutoState createState() => _DetalheProdutoState();
}

class _DetalheProdutoState extends State<DetalheProduto> {
  CategoriaModel? categoriaModel;
  FornecedorModel? fornecedorModel;

  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  getCategoria() async {
    CategoriaController categoriaController = CategoriaController();
    categoriaModel = await categoriaController
        .obtenhaPorId(widget.produtoModel!.idCategoria);

    setState(() {});
  }

  getFornecedor() async {
    FornecedorController forncedorController = FornecedorController();
    fornecedorModel = await forncedorController
        .obtenhaPorId(widget.produtoModel!.idFornecedor);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoria();
    getFornecedor();
  }

  @override
  Widget cardProduto() {

    return ConstrainedBox(constraints: BoxConstraints(minWidth: 340.0),
    child: Container(
      child: MolduraComponent(
          label: 'Produto',
          content: Column(
            children: [
              Row(
                children: [
                  TextComponent(label: 'Nome: '),
                  TextComponent(
                    label: widget.produtoModel!.nome,
                  )
                ],
              ),
              Row(
                children: [
                  TextComponent(label: 'Categoria: '),
                  TextComponent(
                    label: categoriaModel!.nome,
                  )
                ],
              ),
              Row(
                children: [
                  TextComponent(label: 'Fornecedor: '),
                  TextComponent(label: fornecedorModel!.nome)
                ],
              ),
              Row(
                children: [
                  TextComponent(label: 'Descrição: '),
                  TextComponent(
                    label: widget.produtoModel!.descricao,
                  )
                ],
              ),
              Row(
                children: [
                  TextComponent(label: 'Valor Compra: '),
                  TextComponent(
                    label: formatter.format(widget.produtoModel!.valorCompra),
                  )
                ],
              ),
              Row(
                children: [
                  TextComponent(label: 'Valor Venda: '),
                  TextComponent(
                    label: formatter.format(widget.produtoModel!.valorVenda),
                  )
                ],
              ),
            ],
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Buttons extends StatelessWidget {
  GlobalKey<FormState>? formKeyCadastrar;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKeyCadastrar,
        child: (Column(
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

class Estoque extends StatefulWidget {
  ProdutoModel? produtoModel;
  Estoque({Key? key, this.produtoModel}) : super(key: key);

  @override
  _EstoqueState createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  Future<List<EstoqueModel>>? listaEstoqueModel;
  carregarEstoque() {
    final estoqueControlller = EstoqueController();
    listaEstoqueModel =
        estoqueControlller.obtenhaEstoqueProduto(widget.produtoModel!.id);
  }

  @override
  void initState() {
    super.initState();
    carregarEstoque();
  }

  atualizarEstoque(EstoqueModel estoqueModel, int quantidade) async {
    estoqueModel.quantidade += quantidade;

    EstoqueController estoqueController = new EstoqueController();

    final estoque = await estoqueController.atualize(estoqueModel);

    setState(() {});
  }

  removerEstoque(EstoqueModel estoqueModel, int quantidade) async {
    estoqueModel.quantidade -= quantidade;

    EstoqueController estoqueController = new EstoqueController();

    final estoque = await estoqueController.atualize(estoqueModel);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: listaEstoqueModel,
          builder: (BuildContext context,
              AsyncSnapshot<List<EstoqueModel>> snapshot) {
            var listaEstoque;
            if (snapshot.hasData) {
              listaEstoque = snapshot.data!.map((estoque) {
                return ItemEstoqueCard(
                  itemEstoque: estoque,
                  atualizarEstoque: atualizarEstoque,
                  removerEstoque: removerEstoque,
                );
              });
            } else if (snapshot.hasError) {
              print('falha ao carregar estoques !');
            }

            return Column(
              children: [...listaEstoque],
            );
          }),
    );
  }
}

class ItemEstoqueCard extends StatefulWidget {
  EstoqueModel? itemEstoque;
  Function? atualizarEstoque;
  Function? removerEstoque;

  ItemEstoqueCard(
      {Key? key, this.itemEstoque, this.atualizarEstoque, this.removerEstoque})
      : super(key: key);

  @override
  _ItemEstoqueCardState createState() => _ItemEstoqueCardState();
}

class _ItemEstoqueCardState extends State<ItemEstoqueCard> {
  TextEditingController quantidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: colorCinza,
                padding: paddingPadrao,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      label: widget.itemEstoque!.nome.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextComponent(
                      label: 'Quantidade: ' +
                          widget.itemEstoque!.quantidade.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: paddingPadrao,
                      color: colorBranco,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: ButtonComponent(
                            label: 'Atualizar',
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      actions: [
                                        InputComponent(
                                          label: 'Quantidade',
                                          controller: quantidadeController,
                                        ),
                                        ButtonComponent(
                                          label: 'Salvar',
                                          onPressed: () {
                                            widget.atualizarEstoque!(
                                                widget.itemEstoque!,
                                                int.parse(
                                                    quantidadeController.text));
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    )),
                          ))
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: paddingPadrao,
                      color: colorBranco,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: ButtonComponent(
                            label: 'Remover',
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      actions: [
                                        InputComponent(
                                          label: 'Quantidade',
                                          controller: quantidadeController,
                                        ),
                                        ButtonComponent(
                                          label: 'Salvar',
                                          onPressed: () {
                                            widget.removerEstoque!(
                                                widget.itemEstoque!,
                                                int.parse(
                                                    quantidadeController.text));
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    )),
                          ))
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
