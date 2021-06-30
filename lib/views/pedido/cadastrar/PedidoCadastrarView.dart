import 'dart:js';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/ResponsiveComponenet.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:provider/provider.dart';

class PedidoCadastrarView extends StatefulWidget {
  const PedidoCadastrarView({Key? key}) : super(key: key);

  @override
  _PedidoCadastrarViewState createState() => _PedidoCadastrarViewState();
}

class _PedidoCadastrarViewState extends State<PedidoCadastrarView> {
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

    listaProdutos!.forEach((element) {
      print(element.precoCompra);
    });

    setState(() {
      auxListaProdutos = listaProdutos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    carregarProdutos();
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
                Expanded(
                  flex: 14,
                  child: SingleChildScrollView(
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
                ),
                Expanded(
                  flex: 2,
                  child: Resumo(),
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

    this.context!.read<PedidoModel>().setCliente(cliente);
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
    PedidoModel pedido = context.watch<PedidoModel>();

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

class Produto extends StatelessWidget {
  List<ProdutoModel>? listaProdutos;
  Produto({Key? key, this.listaProdutos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardProduto> listaProdutosWidget = listaProdutos!.map((produto) {
      print(produto.nome);
      return CardProduto(produto: produto);
    }).toList();

    return Container(
        child: Column(
      children: [...listaProdutosWidget],
    ));
  }
}

class CardProduto extends StatelessWidget {
  ProdutoModel? produto;

  CardProduto({Key? key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Expanded(
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
                    ),
                    TextComponent(
                      label: produto!.nome,
                    )
                  ],
                ),
                Row(
                  children: [
                    TextComponent(
                      label: 'Categoria:',
                    ),
                    TextComponent(
                      label: produto!.categoria,
                    )
                  ],
                ),
                Row(
                  children: [
                    TextComponent(
                      label: 'Preço:',
                    ),
                    TextComponent(
                      label: produto!.categoria,
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
                      label: 'Teste',
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ButtonCustom(
                        isAdd: true,
                        isRemoved: false,
                        produto: produto,
                      ),
                    ),
                    Expanded(
                      child: ButtonCustom(
                        isAdd: false,
                        isRemoved: true,
                        produto: produto,
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
    var pedido = context.watch<PedidoModel>();
    GestureDetector gestureDetector = GestureDetector();

    if (pedido != null) {
      print('tesa');
    }

    if (isAdd) {
      gestureDetector = GestureDetector(
        onTap: () {
          pedido.setItemPedido(produto!);
        },
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
        onTap: () {},
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
  const Resumo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextComponent(
                  label: context.read<PedidoModel>().getTotal().toString(),
                  cor: colorAzul,
                )
              ],
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
