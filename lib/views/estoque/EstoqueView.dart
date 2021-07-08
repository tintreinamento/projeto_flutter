import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/controllers/EstoqueMovimentacaoController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/EstoqueModel.dart';
import 'package:projeto_flutter/models/EstoqueMovimentacaoModel.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class EstoqueView extends StatefulWidget {
  @override
  _EstoqueViewState createState() => _EstoqueViewState();
}

class ProdutoCategoriaFornecedorModel {
  var produto = new ProdutoModel();
  var categoriaModel = new CategoriaModel();
  var fornecedorModel = new FornecedorModel();
  Future<List<EstoqueMovimentacaoComEstoqueModel>>? estoques;
}

class EstoqueMovimentacaoComEstoqueModel {
  var estoqueMovimentacao = new EstoqueMovimentacaoModel();
  var estoque = new EstoqueModel();
}

class _EstoqueViewState extends State<EstoqueView> {
  bool _active = false;
  ProdutoModel? produtoModel;
  ProdutoCategoriaFornecedorModel? produtoCFMG;

  var formkeyConsulta = GlobalKey<FormState>();
  var formkeyCadastro = GlobalKey<FormState>();
  var nomePedidoController = TextEditingController();
  var nomeEstoqueController = TextEditingController();
  var quantidadeEstoqueController = TextEditingController();

  consultarEstoque() async {
    _active = !_active;

    final produtos =
        await new ProdutoController().obtenhaTodosComCategoriaFornecedor();
    produtos.removeWhere((element) => !element.produto.nome
        .toLowerCase()
        .contains(nomePedidoController.text.toLowerCase()));

    if (produtos.length > 1) {
      abraDialogConsulta(produtos);
    } else if (produtos.length == 1) {
      produtoModel = produtos.single.produto;
      produtoCFMG = produtos.single;
      produtoCFMG!.estoques =
          EstoqueMovimentacaoController().obtenhaPorProduto(produtoModel!.id);
    } else {
      produtoModel = null;
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {});
    });

    setState(() {});
  }

  Future<void> mensagem(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensagem'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  cadastrarEstoque() async {
    var estoque;

    try {
      estoque = await new EstoqueController()
          .obtenhaPorNome(nomeEstoqueController.text);
    } catch (e) {}

    if (estoque != null) {
      mensagem("Estoque com nome " + estoque.nome + " já existe");
      return;
    }

    var estoqueCadastrado = await new EstoqueController()
        .crie(EstoqueModel(nome: nomeEstoqueController.text));

    if (estoqueCadastrado.id != null) {
      mensagem("Estoque cadastrado com sucesso!");
      nomeEstoqueController.clear();
    }
  }

  cadastrarProdutoNoEstoque() async {
    var est = (await new EstoqueController().obtenhaTodos());
    var estProduto = await EstoqueMovimentacaoController().obtenhaTodos();

    Future.delayed(const Duration(milliseconds: 500), () {
      estProduto.forEach((element) {
        if (element.idProduto == produtoCFMG!.produto.id) {
          est.removeWhere((estoq) => estoq.id == element.idEstoque);
        }
      });

      if (est.length == 0) {
        mensagem("Este produto está em todos os estoques.");
        return;
      }

      abraDialogCadastro(est);
    });
  }

  abraDialogCadastro(List<EstoqueModel> estoques) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione o estoque'),
            content: Container(
              child: DropdownButton<EstoqueModel>(
                hint: Text('Selecione o estoque'),
                items: estoques.map((estoque) {
                  return DropdownMenuItem<EstoqueModel>(
                    value: estoque,
                    child: new Text(estoque.nome),
                  );
                }).toList(),
                onChanged: (estoque) async {
                  var estoqueMv = new EstoqueMovimentacaoComEstoqueModel();
                  var estoqueMovimentacaoFuture =
                      EstoqueMovimentacaoController().crie(
                          EstoqueMovimentacaoModel(
                              idEstoque: estoque!.id,
                              idProduto: produtoCFMG!.produto.id,
                              quantidade: 0));
                  estoqueMv.estoque = estoque;
                  estoqueMv.estoqueMovimentacao =
                      await estoqueMovimentacaoFuture;

                  produtoCFMG!.estoques = EstoqueMovimentacaoController()
                      .obtenhaPorProduto(produtoModel!.id);

                  Future.delayed(const Duration(milliseconds: 1000), () {
                    setState(() {});
                  });

                  setState(() {});

                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        });
  }

  abraDialogConsulta(List<ProdutoCategoriaFornecedorModel> produtos) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.height * .5,
                  child: ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, position) {
                      return cardProduto(context, produtos[position]);
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
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
              primeiraRota: '/estoque_cadastro',
              tituloSegundaRota: '',
              segundaRota: ''),
          Expanded(
            child: Container(
                padding: paddingPadrao,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormCadastro(
                        formKeyCadastro: formkeyCadastro,
                        onPressed: cadastrarEstoque,
                        nomeNovoEstoqueController: nomeEstoqueController,
                      ),
                      FormConsulta(
                        formKeyConsultar: formkeyConsulta,
                        onPressed: consultarEstoque,
                        nomePedidoController: nomePedidoController,
                      ),
                      if (produtoModel != null && produtoCFMG != null)
                        Container(
                          child: Column(
                            children: [
                              DetalheProduto(
                                produtoModel: this.produtoModel,
                              ),
                              cardEstoque(context),
                              ButtonComponent(
                                  label: 'Cadastrar Novo',
                                  onPressed: cadastrarProdutoNoEstoque),
                            ],
                          ),
                        ),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }

  var formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  Widget cardProduto(
      BuildContext context, ProdutoCategoriaFornecedorModel produtoCFM) {
    return GestureDetector(
      onTap: () async {
        produtoModel = produtoCFM.produto;
        produtoCFMG = produtoCFM;
        produtoCFMG!.estoques =
            EstoqueMovimentacaoController().obtenhaPorProduto(produtoModel!.id);

        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {});
        });

        setState(() {});

        Navigator.of(context).pop();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 340.0),
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0),
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(235, 231, 231, 1),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextComponent(
                          label: 'ID Produto: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Text(produtoCFM.produto.id.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          label: 'Nome: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Expanded(
                            child: Text(produtoCFM.produto.nome.toString()))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          label: 'Descrição: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Expanded(
                            child: Text(produtoCFM.produto.descricao ?? ""))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          label: 'Categoria: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Expanded(child: Text(produtoCFM.categoriaModel.nome))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          label: 'Valor Compra: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Text(formatter.format(produtoCFM.produto.valorCompra))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          label: 'Valor Venda: ',
                          fontWeight: FontWeight.w700,
                        ),
                        Text(formatter.format(produtoCFM.produto.valorVenda))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  atualizarEstoque(
      EstoqueMovimentacaoModel estoqueModel, int quantidade) async {
    estoqueModel.quantidade = quantidade;

    await new EstoqueMovimentacaoController().atualize(estoqueModel);

    setState(() {});
  }

  Widget cardEstoque(BuildContext context) {
    var lista = FutureBuilder(
        future: produtoCFMG!.estoques,
        builder: (BuildContext context,
            AsyncSnapshot<List<EstoqueMovimentacaoComEstoqueModel>>? snapshot) {
          if (snapshot!.hasData) {
            final listaProdutos = snapshot.data!.map((estoque) {
              return Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: colorCinza,
                              padding: paddingPadrao,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(
                                    label: estoque.estoque.nome.toString(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextComponent(
                                    label: 'Quantidade: ' +
                                        estoque.estoqueMovimentacao.quantidade
                                            .toString(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromRGBO(
                                                          0, 94, 181, 1)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ))),
                                          onPressed: () => {
                                            quantidadeEstoqueController.text =
                                                estoque.estoqueMovimentacao
                                                    .quantidade
                                                    .toString(),
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          actions: [
                                                            InputComponent(
                                                              label:
                                                                  'Quantidade',
                                                              controller:
                                                                  quantidadeEstoqueController,
                                                            ),
                                                            ButtonComponent(
                                                              label:
                                                                  'Adicionar',
                                                              onPressed: () {
                                                                atualizarEstoque(
                                                                    estoque
                                                                        .estoqueMovimentacao,
                                                                    estoque.estoqueMovimentacao
                                                                            .quantidade +
                                                                        int.parse(
                                                                            quantidadeEstoqueController.text));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                          },
                                          child: TextComponent(
                                            fontWeight: FontWeight.bold,
                                            tamanho: 15,
                                            label: '+',
                                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromRGBO(
                                                          0, 94, 181, 1)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ))),
                                          onPressed: () => {
                                            quantidadeEstoqueController.text =
                                                estoque.estoqueMovimentacao
                                                    .quantidade
                                                    .toString(),
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          actions: [
                                                            InputComponent(
                                                              label:
                                                                  'Quantidade',
                                                              controller:
                                                                  quantidadeEstoqueController,
                                                            ),
                                                            ButtonComponent(
                                                              label: 'Remover',
                                                              onPressed: () {
                                                                atualizarEstoque(
                                                                    estoque
                                                                        .estoqueMovimentacao,
                                                                    estoque.estoqueMovimentacao
                                                                            .quantidade -
                                                                        int.parse(
                                                                            quantidadeEstoqueController.text));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                          },
                                          child: TextComponent(
                                            fontWeight: FontWeight.bold,
                                            tamanho: 15,
                                            label: '-',
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            });

            return Column(
              children: [
                ...listaProdutos,
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Falha ao obter os dados...');
          }
          return CircularProgressIndicator();
        });

    return lista;
  }
}

class FormConsulta extends StatelessWidget {
  GlobalKey<FormState>? formKeyConsultar;
  Function? onPressed;
  TextEditingController? nomePedidoController;

  FormConsulta(
      {this.formKeyConsultar, this.onPressed, this.nomePedidoController});

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
                  controller: nomePedidoController,
                ),
                ButtonComponent(label: 'Consultar', onPressed: this.onPressed)
              ],
            )),
      ),
    );
  }
}

class FormCadastro extends StatelessWidget {
  GlobalKey<FormState>? formKeyCadastro;
  Function? onPressed;
  TextEditingController? nomeNovoEstoqueController;

  FormCadastro(
      {this.formKeyCadastro, this.onPressed, this.nomeNovoEstoqueController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKeyCadastro,
        child: MolduraComponent(
            label: 'Cadastrar Estoque',
            content: Column(
              children: [
                InputComponent(
                  label: 'Nome:',
                  controller: nomeNovoEstoqueController,
                ),
                ButtonComponent(label: 'Cadastrar', onPressed: this.onPressed)
              ],
            )),
      ),
    );
  }
}

class DetalheProduto extends StatefulWidget {
  ProdutoModel? produtoModel;

  DetalheProduto({Key? key, this.produtoModel}) : super(key: key);

  @override
  _DetalheProdutoState createState() => _DetalheProdutoState();
}

class _DetalheProdutoState extends State<DetalheProduto> {
  FornecedorModel? fornecedorModel;

  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  getFornecedor() async {
    var fornecedorController = FornecedorController();
    fornecedorModel = await fornecedorController
        .obtenhaPorId(widget.produtoModel!.idFornecedor);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFornecedor();
  }

  Widget cardProduto() {
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 340.0),
        child: Container(
          child: MolduraComponent(
              label: 'Produto',
              content: Column(
                children: [
                  Row(
                    children: [
                      TextComponent(label: 'Nome: '),
                      Expanded(
                        child: Text(widget.produtoModel!.nome),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextComponent(label: 'CPF/CNPJ: '),
                      TextComponent(
                        label: fornecedorModel!.cpfCnpj.toString(),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextComponent(label: 'Telefone: '),
                      TextComponent(
                          label: UtilBrasilFields.obterTelefone(
                              fornecedorModel!.telefone.toString()))
                    ],
                  ),
                  Row(
                    children: [
                      TextComponent(label: 'E-mail: '),
                      Expanded(
                        child: Text(fornecedorModel!.email),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: cardProduto());
  }
}
