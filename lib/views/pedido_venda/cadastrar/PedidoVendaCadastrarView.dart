import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
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
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/controllers/EstoqueMovimentacaoController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/CarrinhoModel.dart';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EstoqueModel.dart';
import 'package:projeto_flutter/models/EstoqueMovimentacaoModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

GlobalKey<FormState> keyFormClientePedidoVenda = new GlobalKey<FormState>();

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

  String searchProduto = "";

  //Busca produto
  void buscarProduto(String nomeProduto) {
    setState(() {
      searchProduto = nomeProduto;
    });
    // var auxListaProdutos = listaProdutos!.where((produto) {
    //   return produto.nome!.toLowerCase().startsWith(nomeProduto.toLowerCase());
    // }).toList();

    // setState(() {
    //   this.auxListaProdutos = auxListaProdutos;
    // });
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
            child: Column(children: [
          SubMenuComponent(
              titulo: 'Pedido Venda',
              tituloPrimeiraRota: 'Cadastrar',
              primeiraRota: '/pedido_venda_cadastrar',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/pedido_venda_consultar'),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FormCliente(),
                      Produto(),
                    ],
                  ),
                )),
                Positioned(bottom: 0, child: Resumo())
              ],
            ),
          )
        ])));
  }
}

class FormCliente extends StatefulWidget {
  FormCliente({
    Key? key,
  }) : super(key: key);

  @override
  _FormClienteState createState() => _FormClienteState();
}

class _FormClienteState extends State<FormCliente> {
  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  carregarCliente(BuildContext context) async {
    ClienteController clienteController = new ClienteController();
    ClienteModel? cliente = await clienteController.obtenhaPorCpf(
        UtilBrasilFields.removeCaracteres(cpfCnpjController.text));

    //Carrega dados do cliente
    nomeController.text = cliente!.nome!;
    //Seta cliente no pedido

    cepController.text = cliente.cep.toString();
    logradouroController.text = cliente.logradouro;
    numeroController.text = cliente.numero.toString();
    bairroController.text = cliente.bairro;
    cidadeController.text = cliente.cidade;
    estadoController.text = cliente.uf;

    this.context.read<CarrinhoModel>().cliente = cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: keyFormClientePedidoVenda,
        child: Column(
          children: [
            MolduraComponent(
              label: 'Consultar',
              content: Column(
                children: [
                  InputComponent(
                    label: 'CPF/CNPJ: ',
                    controller: cpfCnpjController,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfOuCnpjFormatter()
                    ],
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }

                      if (UtilBrasilFields.removeCaracteres(value).length !=
                              11 &&
                          UtilBrasilFields.removeCaracteres(value).length !=
                              14) {
                        return 'Formato de CPF ou CNPJ inválido';
                      }
                      if (UtilBrasilFields.removeCaracteres(value).length ==
                          11) {
                        if (!UtilBrasilFields.isCPFValido(
                            UtilBrasilFields.removeCaracteres(value))) {
                          return 'Informe um CPF válido !';
                        }
                      }
                      if (UtilBrasilFields.removeCaracteres(value).length ==
                          14) {
                        if (!UtilBrasilFields.isCNPJValido(
                            UtilBrasilFields.removeCaracteres(value))) {
                          return 'Informe um CNPJ válido !';
                        }
                      }
                      return null;
                    },
                  ),
                  ButtonComponent(
                    label: 'Consultar',
                    onPressed: () => carregarCliente(context),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MolduraComponent(
              label: 'Cliente',
              content: Column(
                children: [
                  InputComponent(
                    label: 'Nome: ',
                    controller: nomeController,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s")),
                    ],
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MolduraComponent(
              label: 'Endereço',
              content: Column(
                children: [
                  InputComponent(
                    label: 'CEP: ',
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()
                    ],
                    //   onFieldSubmitted: carregarEndereco,
                    controller: cepController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      if (UtilBrasilFields.removeCaracteres(value).length !=
                          8) {
                        return 'CEP inválido';
                      }
                      if (Validator.cep(UtilBrasilFields.obterCep(
                          UtilBrasilFields.removeCaracteres(value),
                          ponto: false))) {
                        return 'CEP inválido';
                      }
                      return null;
                    },
                  ),
                  InputComponent(
                    label: 'Logradouro: ',
                    controller: logradouroController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      return null;
                    },
                  ),
                  InputComponent(
                    label: 'Número: ',
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: numeroController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      return null;
                    },
                  ),
                  InputComponent(
                    label: 'Bairro: ',
                    controller: bairroController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigatório!';
                      }
                      return null;
                    },
                  ),
                  InputComponent(
                    label: 'Cidade: ',
                    controller: cidadeController,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s")),
                    ],
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      return null;
                    },
                  ),
                  InputComponent(
                    label: 'Estado: ',
                    controller: estadoController,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s")),
                    ],
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Campo obrigátorio!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
  Produto({
    Key? key,
  }) : super(key: key);

  @override
  _ProdutoState createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  final nomeController = TextEditingController();
  late Future<List<EstoqueModel>> estoques;
  List<EstoqueMovimentacaoModel>? estoqueMovimentacao;
  late Future<List<ProdutoModel>> produtos;
  bool _isSelectEstoque = false;

  carregarEstoqueMovimentacao(value) async {
    print(value);
    //carregar estoque por id
    estoqueMovimentacao = await EstoqueMovimentacaoController()
        .obtenhaPorEstoque(int.parse(value));

    setState(() {
      _isSelectEstoque = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Carrega estoque
    estoques = EstoqueController().obtenhaTodos();
    produtos = ProdutoController().obtenhaTodos();
  }

  @override
  Widget build(BuildContext context) {
    // final listaProdutosWidget = FutureBuilder(
    //   future: listaProdutos, // a previously-obtained Future<String> or null
    //   builder:
    //       (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
    //     var listaProdutosWidget;
    //     List<Widget> children;
    //     if (snapshot.hasData) {
    //       var listaOrdenadaProduto = snapshot.data!.where((produto) {
    //         return produto.nome!
    //             .toLowerCase()
    //             .startsWith(widget.searchProduto!.toLowerCase());
    //       });

    //       listaProdutosWidget = listaOrdenadaProduto.map((produto) {
    //         print(produto.nome);
    //         return CardProduto(produto: produto);
    //       }).toList();
    //     } else if (snapshot.hasError) {
    //       children = <Widget>[];
    //     } else {
    //       children = const <Widget>[];
    //     }
    //     return Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [...listaProdutosWidget],
    //       ),
    //     );
    //   },
    // );

    // List<CardProduto> listaProdutosWidget =
    //     widget.listaProdutos!.map((produto) {
    //   print(produto.nome);
    //   return CardProduto(produto: produto);
    // }).toList();

    var mediaQuery = MediaQuery.of(context);

    List<Widget> children = [];

    print(_isSelectEstoque);
    if (_isSelectEstoque) {
      estoqueMovimentacao!.forEach((element) {
        children.add(CardProduto(
          idProduto: element.idProduto,
          nomeProduto: nomeController.text,
        ));
      });
    }

    return Container(
        height: mediaQuery.size.height,
        child: FutureBuilder(
            future: estoques,
            builder: (context, AsyncSnapshot<List<EstoqueModel>> snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> selectEstoque = [];
                snapshot.data!.forEach((element) {
                  selectEstoque.add(
                    {
                      'value': element.id.toString(),
                      'label': element.nome.toString(),
                    },
                  );
                });

                return MolduraComponent(
                  label: 'Produtos',
                  content: Column(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            SizedBox(
                              width: mediaQuery.size.width * 0.15,
                              child: TextComponent(
                                label: 'Estoque: ',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: SelectFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 15, bottom: 15),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  191, 188, 188, 1))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  191, 188, 188, 1))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      suffixIcon: Container(
                                        child: Icon(Icons.arrow_drop_down),
                                      )),
                                  labelText: 'Selecione o',
                                  type: SelectFormFieldType
                                      .dropdown, // or can be dialog

                                  items: selectEstoque,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return 'Campo obrigátorio!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    context.read<CarrinhoModel>().idEstoque =
                                        int.parse(value);
                                    print('ada' + value);
                                    carregarEstoqueMovimentacao(value);
                                  },
                                  onSaved: (value) => print(value)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputComponent(
                        label: 'Produto: ',
                        controller: nomeController,
                        onChange: (value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Lista de produtos
                      if (_isSelectEstoque)
                        Column(
                          children: [...children],
                        ),
                      if (!_isSelectEstoque)
                        FutureBuilder(
                          future: produtos,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ProdutoModel>> snapshot) {
                            if (snapshot.hasData) {
                              List<Widget> children = [];
                              snapshot.data!.forEach((element) {
                                children.add(CardProduto(
                                  idProduto: element.id,
                                  nomeProduto: nomeController.text,
                                ));
                              });
                              return Container(
                                child: Column(
                                  children: [...children],
                                ),
                              );
                            }
                            //Para não retonar null
                            return Container();
                          },
                        )
                    ],
                  ),
                );
              }

              return Container();
            }));
  }
}

class CardProduto extends StatefulWidget {
  int? idProduto;
  String? nomeProduto;

  CardProduto({Key? key, this.idProduto, this.nomeProduto}) : super(key: key);

  @override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  CategoriaModel? categoria;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  List<CategoriaModel>? listaCategoria;
  List<Map<String, dynamic>>? selectEstoque;

  //Card produto aqui
  late Future<ProdutoModel> produto;

  String? categoriaNome;
  final estoqueController = EstoqueController();
  getCategoria(value) async {
    CategoriaController categoriaController = new CategoriaController();

    final categoria = await categoriaController.obtenhaPorId(value);

    setState(() {
      this.categoria = categoria;
    });
  }

  getEstoque() async {
    // var estoque =
    //     await estoqueController.obtenhaEstoqueProduto(widget.produto!.id.to);
    // setState(() {
    //   estoque.forEach((element) {
    //     selectEstoque!.add({'value': element.id, 'label': element.nome});
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    produto = ProdutoController().obtenhaPorId(widget.idProduto!);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return FutureBuilder(
        future: produto,
        builder: (BuildContext context, AsyncSnapshot<ProdutoModel> snapshot) {
          if (snapshot.hasData) {
            var regex = new RegExp(widget.nomeProduto!.toLowerCase());
            var teste =
                regex.hasMatch(snapshot.data!.nome.toString().toLowerCase());

            if (teste) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: mediaQuery.size.height * 0.2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: paddingPadrao,
                        color: colorCinza,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.nome),
                            SizedBox(
                              height: 10,
                            ),
                            Text(formatter.format(snapshot.data!.valorVenda))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                context
                                    .watch<CarrinhoModel>()
                                    .getQuantidade(snapshot.data!.id)
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                color: colorVerde,
                                child: IconButton(
                                  color: colorBranco,
                                  icon: Icon(Icons.add),
                                  onPressed: () => context
                                      .read<CarrinhoModel>()
                                      .addItemCarrinho(snapshot.data!),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                color: colorVermelho,
                                child: IconButton(
                                  color: colorBranco,
                                  icon: Icon(
                                    Icons.horizontal_rule_outlined,
                                  ),
                                  onPressed: () => context
                                      .read<CarrinhoModel>()
                                      .removeItemCarrinho(snapshot.data!),
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
          return Container();
        });

    // return Container(
    //   height: MediaQuery.of(context).size.height * .15,
    //   margin: EdgeInsets.only(bottom: 5.0),
    //   child: Row(
    //     children: [
    //       Expanded(
    //           flex: 4,
    //           child: Container(
    //             padding: paddingPadrao,
    //             color: colorCinza,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     TextComponent(
    //                       label: 'Nome:',
    //                       tamanho: 18,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     SizedBox(width: 5.0),
    //                     Expanded(child: Text(widget.produto!.nome)),
    //                   ],
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     TextComponent(
    //                       label: 'Categoria:',
    //                       tamanho: 18,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     SizedBox(width: 5.0),
    //                     Expanded(child: Text(categoria!.nome)),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     TextComponent(
    //                       label: 'Preço:',
    //                       tamanho: 18,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     SizedBox(width: 5.0),
    //                     Expanded(
    //                       child: Text(
    //                           formatter.format(widget.produto!.valorVenda)),
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           )),
    //       Expanded(
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   TextComponent(
    //                     tamanho: 28,
    //                     fontWeight: FontWeight.bold,
    //                     label: context
    //                         .watch<CarrinhoModel>()
    //                         .getQuantidade(widget.produto!.id)
    //                         .toString(),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               height: 40,
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     child: ButtonCustom(
    //                       isAdd: true,
    //                       isRemoved: false,
    //                       produto: widget.produto,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: ButtonCustom(
    //                       isAdd: false,
    //                       isRemoved: true,
    //                       produto: widget.produto,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
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
              tamanho: 18,
              fontWeight: FontWeight.bold,
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
  GlobalKey<FormState>? formCliente;
  Function? limparPedido;
  Function? abrirCarrinho;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  Resumo({Key? key, this.formCliente, this.abrirCarrinho, this.limparPedido})
      : super(key: key);

  finalizarPedido(BuildContext context) async {
    if (keyFormClientePedidoVenda.currentState!.validate()) {
      var carrinho = context.read<CarrinhoModel>();
      if (carrinho.idEstoque != null) {
        final pedidoController = PedidoController();
        final itemPedidoController = ItemPedidoController();
        PedidoModel pedido = new PedidoModel(
            idCliente: carrinho.cliente.id,
            idFuncionario: 1,
            total: carrinho.totalPedido,
            data: carrinho.dataPedido);

        //Criando pedido
        PedidoModel pedidoResposta = await pedidoController.crie(pedido);
        print(pedidoResposta.id);
        carrinho.itemPedido.forEach((element) {
          element.idPedido = pedidoResposta.id;
        });

        // carrinho.itemPedido.forEach((element) async {
        //   //Recebe o estoque
        //   var estoque = await EstoqueMovimentacaoController().obtenhaPorId(carrinho.idEstoque!);
        //   //Atualiza a quantidade
        //   estoque.quantidade -= element.quantidade;
        //   //Seta nova atualização
        //   var resultado = await EstoqueMovimentacaoController().atualizePorEstoqueProduto(estoque);
        // });

        //Realiza a baixa no estoque

        carrinho.itemPedido.forEach((element) async {
          //Recebe o estoque
          var estoque = await EstoqueMovimentacaoController()
              .obtenhaPorId(carrinho.idEstoque!);
          //Atualiza a quantidade
          estoque.quantidade -= element.quantidade;
          //Seta nova atualização
          var resultado =
              await EstoqueMovimentacaoController().atualize(estoque);
        });

        //limpa form
        keyFormClientePedidoVenda.currentState!.reset();
        context.read<CarrinhoModel>().limparCarrinho(); //Chama notificação
        _showMyDialog(context, pedidoResposta);
      } else {
        _showDialog(context, 'Selecione o estoque para realizar o pedido !');
      }
    }
  }

  Future<void> _showMyDialog(
      BuildContext context, PedidoModel pedidoModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pedido: #' + pedidoModel.id.toString(),
            style: TextStyle(
                color: colorAzul, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Data do pedido: ' +
                      UtilData.obterDataDDMMAAAA(
                          DateTime.parse(pedidoModel.data)),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Total do pedido:' + formatter.format(pedidoModel.total),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.15,
      width: mediaQuery.size.width,
      color: colorBranco,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'por ',
                    style: TextStyle(
                        color: colorAzul,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Text(
                      formatter
                          .format(context.watch<CarrinhoModel>().getTotal()),
                      style: TextStyle(
                          color: colorAzul,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: colorVerde,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 48,
                  onPressed: () => finalizarPedido(context),
                  color: colorBranco,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );

    // return Container(
    //     height: 40.0,
    //     child: Row(
    //       children: [
    //         Expanded(
    //             child: GestureDetector(
    //           onTap: () {
    //             abrirCarrinho!();
    //           },
    //           child: Container(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       TextComponent(
    //                         label: 'por',
    //                         tamanho: 18,
    //                         fontWeight: FontWeight.bold,
    //                         cor: colorAzul,
    //                       ),
    //                       SizedBox(
    //                         width: 5,
    //                       ),
    //                       TextComponent(
    //                         label: formatter.format(
    //                             context.watch<CarrinhoModel>().getTotal()),
    //                         tamanho: 24,
    //                         cor: colorAzul,
    //                         fontWeight: FontWeight.bold,
    //                       )
    //                     ]),
    //               ],
    //             ),
    //           ),
    //         )),
    //         Expanded(
    //             child: GestureDetector(
    //           onTap: () {
    //             finalizarPedido(context);
    //           },
    //           child: Container(
    //             color: colorVerde,
    //             child: Align(
    //                 alignment: Alignment.center,
    //                 child: Image(
    //                   image: AssetImage('assets/images/cart.png'),
    //                 )),
    //           ),
    //         ))
    //       ],
    //     ));
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

_showDialog(context, info) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Column(children: [
              TextComponent(
                label: info.toString(),
              ),
              Container(
                width: 241,
                height: 31,
                padding: paddingPadrao,
                margin: EdgeInsets.only(top: 18, bottom: 13),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(0, 94, 181, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    )),
              )
            ])
          ],
        );
      });
}
