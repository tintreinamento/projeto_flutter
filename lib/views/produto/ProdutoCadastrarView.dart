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
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/controllers/ProdutoController.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/models/Produto.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:flutter/src/widgets/navigator.dart';

class ProdutoCadastrarView extends StatefulWidget {
  const ProdutoCadastrarView({Key? key}) : super(key: key);

  @override
  _ProdutoCadastrarViewState createState() => _ProdutoCadastrarViewState();
}

class _ProdutoCadastrarViewState extends State<ProdutoCadastrarView> {
  final _formKeyFornecedor = GlobalKey<FormState>();
  final _formKeyProduto = GlobalKey<FormState>();

  //dados Fornecedor
  final nomeController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  //dados Produto
  final nomeProdutoController = TextEditingController();
  final descricaoController = TextEditingController();
  final categoriaController = TextEditingController();
  final valorCompraController = TextEditingController();
  //final idFornecedorController =TextEditingController(); //armazenar ID do Fornecedor para o produto

  pegarNome() {
    print(nomeController.text);
  }

  limparCampos() {
    nomeController.text = '';
    cpfCnpjController.text = '';
    emailController.text = '';
    telefoneController.text = '';
    nomeProdutoController.text = '';
    descricaoController.text = '';
    categoriaController.text = '';
    valorCompraController.text = '';
  }

  pegaraNome(text) {
    print(nomeController.text);
  }

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Alerta
  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Cadastro concluido!"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
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

  consultarFornecedor() async {
    //Consultando dados do cliente através da API
    FornecedorController fornecedorController = new FornecedorController();
    final fornecedor =
        await fornecedorController.obtenhaPorNome(nomeController.text);

    //Caso exista o cliente cadastrado, preencha os campos com as respectivas informações
    //nomeConsultaController = nomeController.text;
    cpfCnpjController.text = UtilBrasilFields.obterCnpj(fornecedor.cpfCnpj);
    emailController.text = fornecedor.email;
    telefoneController.text = fornecedor.telefone;
    //idFornecedorController.text = fornecedor.id;
  }

  //Botão para inserção do produto usando a API
  cadastrarProduto() {
    if (_formKeyFornecedor.currentState!.validate()) {
      if (_formKeyProduto.currentState!.validate()) {
        //Cadastrar os dados na API

        ProdutoModel produtoModel = ProdutoModel(
            nome: nomeProdutoController.text,
            descricao: descricaoController.text,
            idCategoria: categoriaController.text,
            valorCompra: valorCompraController.text
            /*idFornecedor: idFornecedorController.text*/);

        ProdutoController produtoController = ProdutoController();

        produtoController.crie(produtoModel);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formFornecedor = Form(
      key: _formKeyFornecedor,
      child: Column(
        children: [
          InputComponent(
            label: 'Nome: ',
            controller: nomeController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo nome vazio !';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'CPF/CNPJ: ',
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              CpfOuCnpjFormatter()
            ],
            controller: cpfCnpjController,
            //validator: validarCpfCnpj,
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'E-mail: ',
            controller: emailController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo e-mail vazio !';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
            label: 'Telefone: ',
            controller: telefoneController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo telefone vazio !';
              }
              return null;
            },
          ),
        ],
      ),
    );
////////////////////////////////////////////////////// 2 form ////////////////////////////////////////////////////
    final formProduto = Container(
      child: Form(
        key: _formKeyProduto,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputComponent(
              label: 'Nome: ',
              controller: nomeProdutoController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo nome vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Descricão: ',
              controller: descricaoController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo descrição vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Categoria: ',
              controller: categoriaController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo categoria vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Valor de compra: ',
              controller: valorCompraController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo valor de compra vazio !';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: Container(
          child: Column(
            children: [
              SubMenuComponent(
                titulo: 'Produto',
                tituloPrimeiraRota: 'Cadastro',
                primeiraRota: '/cadastrar_produto',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/consultar_produto',
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
                        onPressed: consultarFornecedor,
                      ),
                      FormComponent(
                        label: 'Produto',
                        content: formProduto,
                      ),
                      ButtonComponent(
                        label: 'Cadastrar',
                        onPressed: cadastrarProduto,

                        //{Navigator.of(context).pop();}
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
