import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoFornecedorController.dart';
import 'package:projeto_flutter/controllers/PedidoFornecedorController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ItemPedidoFornecedorModel.dart';
import 'package:projeto_flutter/models/PedidoFornecedorModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/models/carrinhocompra.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter/controllers/EnderecoController.dart';
import 'package:projeto_flutter/controllers/EstadoController.dart';
import 'package:projeto_flutter/controllers/CidadeController.dart';

class PedidoCompraCadastroView extends StatefulWidget {
  const PedidoCompraCadastroView({Key? key}) : super(key: key);

  @override
  _PedidoCompraCadastroViewState createState() =>
      _PedidoCompraCadastroViewState();
}

TextEditingController idFornecedorController = TextEditingController();
TextEditingController cpfCnpjController = TextEditingController();
TextEditingController nomeFornecedorController = TextEditingController();
TextEditingController cepController = TextEditingController();
TextEditingController logradouroController = TextEditingController();
TextEditingController complementoController = TextEditingController();
TextEditingController numeroController = TextEditingController();
TextEditingController bairroController = TextEditingController();
TextEditingController cidadeController = TextEditingController();
TextEditingController estadoController = TextEditingController();

class _PedidoCompraCadastroViewState extends State<PedidoCompraCadastroView> {
  bool active = false;

  List<ProdutoModel>? listaProdutos;
  List<ProdutoModel>? auxListaProdutos;

  GlobalKey<FormState> formFornecedor = new GlobalKey<FormState>();
  GlobalKey<FormState> formEndereco = new GlobalKey<FormState>();
  GlobalKey<FormState> formConsultaProduto = new GlobalKey<FormState>();

  String searchProduto = "";

  void limparPedido() {
    cpfCnpjController.clear();
    nomeFornecedorController.clear();
    cepController.clear();
    logradouroController.clear();
    numeroController.clear();
    bairroController.clear();
    cidadeController.clear();
    estadoController.clear();
    setState(() {});
  }

  //Busca produto
  void buscarProduto(String nomeProduto) {
    setState(() {
      searchProduto = nomeProduto;
    });
  }

  void carregarProdutos() async {
    ProdutoController produtoController = new ProdutoController();
    listaProdutos = await produtoController.obtenhaTodos();

    setState(() {
      auxListaProdutos = listaProdutos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    carregarProdutos();
  }

  abrirCarrinho() {
    setState(() {
      active = false; // caso resolve a api !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        child: Column(
          children: [
            SubMenuComponent(
                titulo: 'Pedido Compra',
                tituloPrimeiraRota: 'Cadastrar',
                primeiraRota: '/pedido_compra_cadastrar',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/pedido_compra_consultar'),
            Expanded(
              flex: 15,
              child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      FormFornecedor(formFornecedor: formFornecedor),
                      FormConsultaProduto(
                        formConsultaProduto: formConsultaProduto,
                        buscarProduto: buscarProduto,
                      ),
                      if (listaProdutos != null)
                        Produto(
                          searchProduto: searchProduto,
                          listaProdutos: auxListaProdutos,
                        ),
                    ],
                  )),
                  ProdutoCarrinhoWidget(
                    active: active,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Resumo(
                  limparPedido: limparPedido,
                  formFornecedor: formFornecedor,
                  abrirCarrinho: abrirCarrinho),
            )
          ],
        ),
      ),
    );
  }
}

class FormFornecedor extends StatefulWidget {
  GlobalKey<FormState> formFornecedor;

  FormFornecedor({Key? key, required this.formFornecedor}) : super(key: key);

  @override
  _FormFornecedorState createState() => _FormFornecedorState();
}

class _FormFornecedorState extends State<FormFornecedor> {
  // BuildContext? context;

  isEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Campo vazio !';
    }
    return null;
  }

  isCpfCnpjValidator(cpfCnpj) {
    if (cpfCnpj == null || cpfCnpj.isEmpty) {
      return 'Campo vazio !';
    } else {
      var auxCpfCnpj = UtilBrasilFields.removeCaracteres(cpfCnpj);
      if (auxCpfCnpj.length == 11 &&
          !UtilBrasilFields.isCPFValido(auxCpfCnpj)) {
        return 'CPF inválido !';
      }
      if (auxCpfCnpj.length == 14 &&
          !UtilBrasilFields.isCNPJValido(auxCpfCnpj)) {
        return 'CNPJ inválido !';
      }
    }
  }

  carregarFornecedor(BuildContext context) async {
    var fornecedorController = new FornecedorController();
    var fornecedor = await fornecedorController.obtenhaPorCpfCnpj(
        UtilBrasilFields.removeCaracteres(cpfCnpjController.text));

    nomeFornecedorController.text = fornecedor!.nome;

    var enderecoController = new EnderecoController();
    var endereco =
        await enderecoController.obtenhaPorIdFornecedor(fornecedor.id);

    cepController.text = endereco!.cep.toString();
    logradouroController.text = endereco.logradouro;
    numeroController.text = endereco.numero.toString();
    bairroController.text = endereco.bairro;

    var cidadeController1 = new CidadeController();
    var cidade = await cidadeController1.obtenhaPorId(endereco.idCidade);

    cidadeController.text = cidade!.nome;

    var estadoController1 = new EstadoController();
    var estado = await estadoController1.obtenhaPorId(endereco.idEstado);

    estadoController.text = estado!.nome;

    this.context.read<CarrinhoCompraModel>().fornecedor = fornecedor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: widget.formFornecedor,
      child: Column(
        children: [
          MolduraComponent(
            label: 'Consultar',
            content: Column(
              children: [
                InputComponent(
                  label: 'CPF/CNPJ: ',
                  controller: cpfCnpjController,
                  validator: (cpfCnpj) {
                    return isCpfCnpjValidator(cpfCnpj);
                  },
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfOuCnpjFormatter()
                  ],
                ),
                ButtonComponent(
                  label: 'Consultar',
                  onPressed: () {
                    carregarFornecedor(context);
                  },
                )
              ],
            ),
          ),
          MolduraComponent(
            label: 'Fornecedor',
            content: Column(
              children: [
                InputComponent(
                  label: 'Nome: ',
                  controller: nomeFornecedorController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
              ],
            ),
          ),
          MolduraComponent(
            label: 'Endereço',
            content: Column(
              children: [
                InputComponent(
                  label: 'CEP: ',
                  controller: cepController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                ),
                InputComponent(
                  label: 'Logradouro: ',
                  controller: logradouroController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
                InputComponent(
                  label: 'Número: ',
                  controller: numeroController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
                InputComponent(
                  label: 'Bairro: ',
                  controller: bairroController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
                InputComponent(
                  label: 'Cidade: ',
                  controller: cidadeController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
                InputComponent(
                  label: 'Estado: ',
                  controller: estadoController,
                  validator: (value) {
                    return isEmpty(value);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class FormConsultaProduto extends StatelessWidget {
  GlobalKey<FormState> formConsultaProduto;
  Function? buscarProduto;
  FormConsultaProduto(
      {Key? key, required this.formConsultaProduto, this.buscarProduto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formConsultaProduto,
        child: Column(children: [
          MolduraComponent(
              label: 'Consultar',
              content: Column(
                children: [
                  InputComponent(
                    label: 'Produto: ',
                    onChange: buscarProduto,
                  ),
                ],
              ))
        ]));
  }
}

class Produto extends StatefulWidget {
  List<ProdutoModel>? listaProdutos;
  String? searchProduto;

  Produto({Key? key, this.listaProdutos, this.searchProduto}) : super(key: key);

  @override
  _ProdutoState createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  String? categoriaNome;
  late Future<List<ProdutoModel>> listaProdutos;

  void carregarProdutos() {
    ProdutoController produtoController = new ProdutoController();
    listaProdutos = produtoController.obtenhaTodos();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final listaProdutosWidget = FutureBuilder(
      future: listaProdutos, // a previously-obtained Future<String> or null
      builder:
          (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        var listaProdutosWidget;
        List<Widget> children;
        if (snapshot.hasData) {
          var listaOrdenadaProduto = snapshot.data!.where((produto) {
            return produto.nome!
                .toLowerCase()
                .startsWith(widget.searchProduto!.toLowerCase());
          });

          listaProdutosWidget = listaOrdenadaProduto.map((produto) {
            return CardProduto(produto: produto);
          }).toList();
        } else if (snapshot.hasError) {
          children = <Widget>[];
        } else {
          children = const <Widget>[];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...listaProdutosWidget],
          ),
        );
      },
    );

    return Container(
        child: SingleChildScrollView(
      child: listaProdutosWidget,
    ));
  }
}

class CardProduto extends StatefulWidget {
  ProdutoModel? produto;

  CardProduto({Key? key, this.produto}) : super(key: key);

  @override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  CategoriaModel? categoria;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  List<CategoriaModel>? listaCategoria;
  List<Map<String, dynamic>>? selectEstoque;

  String? categoriaNome;
  final estoqueController = EstoqueController();
  getCategoria(value) async {
    var categoriaController = new CategoriaController();
    final categoria = await categoriaController.obtenhaPorId(value);

    setState(() {
      this.categoria = categoria;
    });
  }

  getEstoque() async {
    // var estoque =
    //     await estoqueController.obtenhaEstoqueProduto(widget.produto!.id);
    // setState(() {
    //   estoque.forEach((element) {
    //     selectEstoque!.add({'value': element.id, 'label': element.nome});
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    getCategoria(widget.produto!.idCategoria);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      margin: EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                padding: paddingPadrao,
                color: colorCinza,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextComponent(
                          label: 'Nome:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        Expanded(child: Text(widget.produto!.nome)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextComponent(
                          label: 'Categoria:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        Expanded(child: Text(categoria!.nome)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextComponent(
                          label: 'Preço:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: Text(
                              formatter.format(widget.produto!.valorVenda)),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextComponent(
                        tamanho: 28,
                        fontWeight: FontWeight.bold,
                        label: context
                            .watch<CarrinhoCompraModel>()
                            .getQuantidade(widget.produto!.id)
                            .toString(),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonCustom(
                          isAdd: true,
                          isRemoved: false,
                          produto: widget.produto,
                        ),
                      ),
                      Expanded(
                        child: ButtonCustom(
                          isAdd: false,
                          isRemoved: true,
                          produto: widget.produto,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  bool isAdd = false;
  bool isRemoved = false;
  ProdutoModel? produto;

  ButtonCustom(
      {Key? key, required this.isAdd, required this.isRemoved, this.produto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GestureDetector gestureDetector = GestureDetector();

    if (isAdd) {
      gestureDetector = GestureDetector(
        onTap: () =>
            context.read<CarrinhoCompraModel>().addItemCarrinho(produto!),
        child: Container(
          color: colorVerde,
          child: Align(
            alignment: Alignment.center,
            child: TextComponent(
              label: '+',
              cor: colorBranco,
              tamanho: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (isRemoved) {
      gestureDetector = GestureDetector(
        onTap: () =>
            context.read<CarrinhoCompraModel>().removeItemCarrinho(produto!),
        child: Container(
          color: colorVermelho,
          child: Align(
            alignment: Alignment.center,
            child: TextComponent(
              label: '-',
              cor: colorBranco,
            ),
          ),
        ),
      );
    }

    return Container(
      child: gestureDetector,
    );
  }
}

class Resumo extends StatelessWidget {
  GlobalKey<FormState>? formFornecedor;
  Function? limparPedido;
  Function? abrirCarrinho;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  Resumo({Key? key, this.formFornecedor, this.abrirCarrinho, this.limparPedido})
      : super(key: key);

  finalizarPedido(BuildContext context) async {
    if (formFornecedor!.currentState!.validate()) {
      var carrinho = context.read<CarrinhoCompraModel>();
      final pedidoController = PedidoFornecedorController();
      final itemPedidoController = ItemPedidoFornecedorController();
      var pedido = new PedidoFornecedorModel(
          idFornecedor: carrinho.fornecedor.id,
          idFuncionario: 1,
          total: carrinho.totalPedido,
          data: carrinho.dataPedido);

      //Criando pedido
      // var pedidoResposta = await pedidoController.crie(pedido);

      // carrinho.itemPedido.forEach((element) {
      //   element.idPedido = pedidoResposta.id;
      // });

      //Realiza a baixa no estoque

      //Enviado items
      carrinho.itemPedido.forEach((element) async {
        await itemPedidoController.crie(element);
      });

      //limpa form

      //  formCliente!.currentState!.reset();
      limparPedido!();
      context.read<CarrinhoCompraModel>().limparCarrinho(); //Chama notificação
      // _showMyDialog(context, pedidoResposta);
    }
  }

  Future<void> _showMyDialog(
      BuildContext context, PedidoFornecedorModel pedidoModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextComponent(
            label: 'Pedido: #' + pedidoModel.id.toString(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextComponent(
                  label: 'Data do pedido: ' +
                      UtilData.obterDataDDMMAAAA(
                          DateTime.parse(pedidoModel.data)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextComponent(
                  label:
                      'Total do pedido:' + formatter.format(pedidoModel.total),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confimar pedido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                abrirCarrinho!();
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextComponent(
                            label: 'por',
                            tamanho: 18,
                            fontWeight: FontWeight.bold,
                            cor: colorAzul,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextComponent(
                            label: formatter.format(context
                                .watch<CarrinhoCompraModel>()
                                .getTotal()),
                            tamanho: 24,
                            cor: colorAzul,
                            fontWeight: FontWeight.bold,
                          )
                        ]),
                  ],
                ),
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                finalizarPedido(context);
              },
              child: Container(
                color: colorVerde,
                child: Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/cart.png'),
                    )),
              ),
            ))
          ],
        ));
  }
}

//Animação

class ProdutoCarrinhoWidget extends StatefulWidget {
  final bool? active;
  final Function? onTap;

  ProdutoCarrinhoWidget({Key? key, this.active, this.onTap}) : super(key: key);

  @override
  _ProdutoCarrinhoWidgetState createState() => _ProdutoCarrinhoWidgetState();
}

class _ProdutoCarrinhoWidgetState extends State<ProdutoCarrinhoWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final carrinhoCompra = context.watch<CarrinhoCompraModel>();

    var listaItemCarrinho = carrinhoCompra.itemPedido.map((itemPedido) {
      return SizedBox(
        width: size.width,
        height: size.height * 0.20,
        child: ItemCarrinhoCard(itemPedido: itemPedido),
      );
    }).toList();

    return AnimatedPositioned(
        child: Container(
          decoration: BoxDecoration(
              color: colorCinza, borderRadius: BorderRadius.circular(16)),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.70,
          margin: marginPadrao,
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: colorCinza, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  label: 'Carrinho de compras',
                  tamanho: 16,
                  cor: colorAzul,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [...listaItemCarrinho],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        curve: Curves.decelerate,
        bottom: widget.active! ? 0 : -700,
        duration: Duration(milliseconds: 500));
  }
}

class ItemCarrinhoCard extends StatelessWidget {
  ItemPedidoFornecedorModel itemPedido;

  ItemCarrinhoCard({Key? key, required this.itemPedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: paddingPadrao,
      margin: marginPadrao,
      decoration: BoxDecoration(
          color: colorBranco, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Nome: '),
                        TextComponent(label: itemPedido.idProduto.toString()),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Categoria: '),
                        TextComponent(label: itemPedido.idProduto.toString()),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        TextComponent(label: 'Preço: '),
                        TextComponent(label: itemPedido.idProduto.toString()),
                      ],
                    ),
                  )
                ]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      TextComponent(
                          label: context
                              .read<CarrinhoCompraModel>()
                              .getQuantidade(itemPedido.idProduto)
                              .toString()),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
