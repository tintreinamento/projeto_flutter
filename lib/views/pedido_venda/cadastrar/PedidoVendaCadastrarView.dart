import 'dart:js';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/ResponsiveComponenet.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CarrinhoModel.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:provider/provider.dart';

class PedidoVendaCadastraView extends StatefulWidget {
  const PedidoVendaCadastraView({Key? key}) : super(key: key);

  @override
  _PedidoVendaCadastraViewState createState() =>
      _PedidoVendaCadastraViewState();
}

class _PedidoVendaCadastraViewState extends State<PedidoVendaCadastraView> {
  bool active = false;

  List<ProdutoModel>? listaProdutos;
  List<ProdutoModel>? auxListaProdutos;

  GlobalKey<FormState> formCliente = new GlobalKey<FormState>();
  GlobalKey<FormState> formEndereco = new GlobalKey<FormState>();
  GlobalKey<FormState> formConsultaProduto = new GlobalKey<FormState>();

  //Busca produto
  void buscarProduto(String nomeProduto) {
    auxListaProdutos = listaProdutos!.where((produto) {
      return produto.nome!.toLowerCase().startsWith(nomeProduto.toLowerCase());
    }).toList();

    setState(() {});
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
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ResponsiveComponent(
      mobile: Container(
        child: Scaffold(
          appBar: AppBarComponent(),
          drawer: DrawerComponent(),
          body: Container(
            child: Column(
              children: [
                SubMenuComponent(
                    titulo: 'Pedido Venda',
                    tituloPrimeiraRota: 'Cadastrar',
                    primeiraRota: '/pedido_venda_cadastrar',
                    tituloSegundaRota: 'Consultar',
                    segundaRota: '/pedido_venda_consultar'),
                Expanded(
                  flex: 15,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                          child: Column(
                        children: [
                          FormCliente(formCliente: formCliente),
                          FormEndereco(formEndereco: formEndereco),
                          FormConsultaProduto(
                            formConsultaProduto: formConsultaProduto,
                            buscarProduto: buscarProduto,
                          ),
                          if (listaProdutos != null)
                            Produto(
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
                  child: Resumo(abrirCarrinho: abrirCarrinho),
                )
              ],
            ),
          ),
        ),
      ),
      tablet: Container(
        color: colorCinza,
      ),
      desktop: Container(
        color: colorVerde,
      ),
    ));
  }
}

class FormCliente extends StatelessWidget {
  BuildContext? context;
  GlobalKey<FormState> formCliente;

  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();

  FormCliente({Key? key, required this.formCliente}) : super(key: key);

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

  carregarCliente() async {
    ClienteController clienteController = new ClienteController();
    ClienteModel cliente = await clienteController.obtenhaPorCpf(
        UtilBrasilFields.removeCaracteres(cpfCnpjController.text));

    //Carrega dados do cliente
    nomeClienteController.text = cliente.nome!;
    //Seta cliente no pedido

    //  this.context!.read<CarrinhoModel>().cliente = cliente;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        child: Form(
      key: formCliente,
      child: Column(
        children: [
          MolduraComponent(
            label: 'Consultar',
            content: Column(
              children: [
                InputComponent(
                  label: 'CPF/CNPJ: ',
                  controller: cpfCnpjController,
                  // onFieldSubmitted: carregarCliente,
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
                  onPressed: carregarCliente,
                )
              ],
            ),
          ),
          MolduraComponent(
            label: 'Cliente',
            content: Column(
              children: [
                InputComponent(
                  label: 'Nome: ',
                  controller: nomeClienteController,
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

class FormEndereco extends StatelessWidget {
  GlobalKey<FormState> formEndereco;

  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  FormEndereco({Key? key, required this.formEndereco}) : super(key: key);

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

  carregarEndereco() {
    print('t');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: formEndereco,
      child: Column(
        children: [
          MolduraComponent(
            label: 'Endereço',
            content: Column(
              children: [
                InputComponent(
                  label: 'CEP: ',
                  controller: cepController,
                  // onFieldSubmitted: carregarEndereco,
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
                  label: 'Complemento: ',
                  controller: complementoController,
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
                    //controller: cpfCnpjController,
                    // onFieldSubmitted: carregarCliente,
                  ),
                ],
              ))
        ]));
  }
}

class Produto extends StatefulWidget {
  List<ProdutoModel>? listaProdutos;

  Produto({Key? key, this.listaProdutos}) : super(key: key);

  @override
  _ProdutoState createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  String? categoriaNome;

  @override
  Widget build(BuildContext context) {
    List<CardProduto> listaProdutosWidget =
        widget.listaProdutos!.map((produto) {
      print(produto.nome);
      return CardProduto(produto: produto);
    }).toList();

    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [...listaProdutosWidget],
    )));
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

  String? categoriaNome;

  getCategoria(value) async {
    CategoriaController categoriaController = new CategoriaController();

    final categoria = await categoriaController.obtenhaPorId(value);

    setState(() {
      this.categoria = categoria;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getCategoria(widget.produto!.idCategoria);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      margin: EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: paddingPadrao,
                color: colorCinza,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextComponent(
                          label: 'Nome:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        TextComponent(
                          label: widget.produto!.nome,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        TextComponent(
                          label: 'Categoria:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        TextComponent(
                          label: categoria!.nome,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        TextComponent(
                          label: 'Preço:',
                          tamanho: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5.0),
                        TextComponent(
                          label: formatter.format(widget.produto!.valorCompra),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextComponent(
                      label: context
                          .watch<CarrinhoModel>()
                          .getQuantidade(widget.produto!.id)
                          .toString(),
                    )
                  ],
                ),
                Row(
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
        onTap: () => context.read<CarrinhoModel>().addItemCarrinho(produto!),
        child: Container(
          color: colorVerde,
          child: Align(
            alignment: Alignment.center,
            child: TextComponent(
              label: '+',
              cor: colorBranco,
            ),
          ),
        ),
      );
    }

    if (isRemoved) {
      gestureDetector = GestureDetector(
        onTap: () => context.read<CarrinhoModel>().removeItemCarrinho(produto!),
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
  Function? abrirCarrinho;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  Resumo({Key? key, this.abrirCarrinho}) : super(key: key);

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
                            cor: colorAzul,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextComponent(
                            label: formatter.format(
                                context.watch<CarrinhoModel>().getTotal()),
                            tamanho: 24,
                            cor: colorAzul,
                          )
                        ]),
                  ],
                ),
              ),
            )),
            Expanded(
                child: GestureDetector(
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
    final carrinhoCompra = context.watch<CarrinhoModel>();

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
  ItemPedidoModel itemPedido;

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
                              .read<CarrinhoModel>()
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
