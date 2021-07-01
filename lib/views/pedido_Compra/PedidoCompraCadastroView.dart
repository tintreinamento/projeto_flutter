import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DropDownComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/inputDropDownComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/models/Produto.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:flutter/src/widgets/navigator.dart';

class PedidoCompraCadastroView extends StatefulWidget {
  const PedidoCompraCadastroView({Key? key}) : super(key: key);

  @override
  _PedidoCompraCadastroViewState createState() =>
      _PedidoCompraCadastroViewState();
}

class _PedidoCompraCadastroViewState extends State<PedidoCompraCadastroView> {
  final _formKeyFornecedor = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();
  final _formKeyEstoque = GlobalKey<FormState>();
  final _formKeyProduto = GlobalKey<FormState>();

  //dados Fornecedor
  final cpfCnpjController = TextEditingController();

  //dados do endereço
  final cepController = TextEditingController();
  final logradouroController = TextEditingController();
  final numController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();

  //dados do estoque
  final nomeEstoqueController = TextEditingController();

  //dados produto
  final nomeProdutoController = TextEditingController();
  final categoriaController = TextEditingController();
  final valorCompraController = TextEditingController();

  selectEstoque(value) {
    nomeEstoqueController.text = value;
  }

  limparCampos() {
    cpfCnpjController.text = '';
    cepController.text = '';
    logradouroController.text = '';
    numController.text = '';
    bairroController.text = '';
    categoriaController.text = '';
    cidadeController.text = '';
    estadoController.text = '';
    nomeEstoqueController.text = '';
  }

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //validador de cpf/cnpj
  String? validarCpfCnpj(cpfCnpj) {
    if (isVazio(cpfCnpj)) {
      return 'Campo CPF/CNPJ vazio';
    }

    var cpfLimpo = UtilBrasilFields.removeCaracteres(cpfCnpj);

    if (cpfLimpo.length == 11) {
      if (!UtilBrasilFields.isCPFValido(cpfLimpo)) {
        return 'CPF inválido';
      }
    } else if (cpfLimpo.length == 14) {
      if (!UtilBrasilFields.isCNPJValido(cpfLimpo)) {
        return 'CNPJ inválido!';
      }
    } else {
      return 'CPF/CNPJ inválido!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////// 1 form ////////////////////////////////////////////////////
    final formFornecedor = Form(
      key: _formKeyFornecedor,
      child: Column(
        children: [
          InputComponent(
            label: 'Cpf/cnpj: ',
            controller: cpfCnpjController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo nome vazio !';
              }
              return null;
            },
          ),
        ],
      ),
    );
////////////////////////////////////////////////////// 2 form ////////////////////////////////////////////////////
    final formEndereco = Container(
      child: Form(
        key: _formKeyEndereco,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputComponent(
              label: 'Cep: ',
              controller: cepController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Cep vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Descricão: ',
              controller: logradouroController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Logradouro vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Categoria: ',
              controller: numController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Num vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Valor de compra: ',
              controller: bairroController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Bairro vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Cidade: ',
              controller: cidadeController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Cidade vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Estado: ',
              controller: estadoController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo Estado vazio !';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
////////////////////////////////////////////////////// 3 form ////////////////////////////////////////////////////
    final formEstoque = Form(
      key: _formKeyEstoque,
      child: Column(
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: 260.0),
              child: InputDropDownComponent(
                label: 'Estoque:',
                labelDropDown: 'Selecione o estoque',
                items: ['Filial 01', 'Filial 02', 'Filial 03', 'Filial 04'],
                onChanged: selectEstoque,
              )),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: Container(
          child: Column(
            children: [
              SubMenuComponent(
                titulo: 'Pedido de compra',
                tituloPrimeiraRota: 'Compra',
                primeiraRota: '/pedido_compra',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/consultar_pedido_compra',
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    children: [
                      FormComponent(
                        label: 'Fornecedor',
                        content: formFornecedor,
                      ),
                      ButtonComponent(
                        label: 'Consultar',
                        onPressed: () {},
                      ),
                      FormComponent(
                        label: 'Endereço',
                        content: formEndereco,
                      ),
                      FormComponent(
                        label: 'Estoque',
                        content: formEstoque,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
