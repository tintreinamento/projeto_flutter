import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/CidadeController.dart';
import 'package:projeto_flutter/controllers/EnderecoController.dart';
import 'package:projeto_flutter/controllers/EstadoController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/models/CidadeModel.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/EstadoModel.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';

class FornecedorCadastrarView extends StatefulWidget {
  const FornecedorCadastrarView({Key? key}) : super(key: key);

  @override
  _FornecedorCadastrarViewState createState() =>
      _FornecedorCadastrarViewState();
}

class _FornecedorCadastrarViewState extends State<FornecedorCadastrarView> {
  final _formKeyFornecedor = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();

  //Dados de fornecedor
  final nomeController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  //Dados de endereço
  final cepController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();

  pegarNome() {
    print(nomeController.text);
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

  String? validarCpfCnpj(cpfCnpj) {
    if (isVazio(cpfCnpj)) {
      return 'Campo CPF/CNPJ vazio!';
    }

    var cpfLimpo = UtilBrasilFields.removeCaracteres(cpfCnpj);

    if (cpfLimpo.length == 11) {
      if (!UtilBrasilFields.isCPFValido(cpfLimpo)) {
        return 'CPF inválido!';
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

  limpaCampos() {
    nomeController.clear();
    cpfCnpjController.clear();
    emailController.clear();
    telefoneController.clear();
    cepController.clear();
    logradouroController.clear();
    numeroController.clear();
    bairroController.clear();
    cidadeController.clear();
    estadoController.clear();
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  cadastrarFornecedor() async {
    if (_formKeyFornecedor.currentState!.validate()) {
      if (_formKeyEndereco.currentState!.validate()) {
        //Cadastrar os dados na API
        var fornecedorModel = FornecedorModel(
            nome: nomeController.text.toString(),
            cpfCnpj: int.parse(UtilBrasilFields.removeCaracteres(
                cpfCnpjController.text.toString())),
            email: emailController.text.toString(),
            telefone: int.parse(UtilBrasilFields.removeCaracteres(
                telefoneController.text.toString())));

        var fornecedorControllerApi = FornecedorController();
        var fornecedor = await fornecedorControllerApi.crie(fornecedorModel);

        // limpaCampos();

        var estadoModel = EstadoModel(idPais: 315, nome: estadoController.text);
        var estadoControllerApi = EstadoController();
        var estado = await estadoControllerApi.crie(estadoModel);

        var cidadeModel =
            new CidadeModel(idEstado: estado.id, nome: cidadeController.text);

        var cidadeControllerApi = CidadeController();
        var cidade = await cidadeControllerApi.crie(cidadeModel);

        var enderecoModel = EnderecoModel(
            idCidade: cidade.id,
            idEstado: estado.id,
            idFornecedor: fornecedor.id,
            idPais: 315,
            cep: UtilBrasilFields.removeCaracteres(cepController.text),
            logradouro: logradouroController.text,
            numero: numeroController.text,
            bairro: bairroController.text);

        var enderecoControllerApi = EnderecoController();
        await enderecoControllerApi.crie(enderecoModel);
        limpaCampos();
        efetivaCadastro();
      }
    }
  }

  Future<void> efetivaCadastro() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensagem'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Fornecedor cadastrado com sucesso!'),
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
            validator: validarCpfCnpj,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'E-mail: ',
            controller: emailController,
            validator: (value) {
              print(isEmail(value.toString()));
              if (isVazio(value)) {
                return 'Campo e-mail vazio !';
              } else if (isEmail(value.toString()) == false) {
                return 'Campo de e-mail inválido!';
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
            label: 'Celular: ',
            controller: telefoneController,
            validator: (value) {
              if (isVazio(value)) {
                return 'Campo telefone vazio !';
              } else if (value!.length < 15) {
                return 'Número de telefone inválido!';
              }
              return null;
            },
          ),
        ],
      ),
    );

    final formEndereco = Container(
      child: Form(
        key: _formKeyEndereco,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputComponent(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
              label: 'CEP: ',
              controller: cepController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo CEP vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Logradouro: ',
              controller: logradouroController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo logradouro vazio !';
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
              ],
              label: 'Número: ',
              controller: numeroController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo número vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              label: 'Bairro: ',
              controller: bairroController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo bairro vazio !';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputComponent(
              //   inputFormatter: [
              //   FilteringTextInputFormatter.singleLineFormatter,
              // ],
              label: 'Cidade: ',
              controller: cidadeController,
              validator: (value) {
                if (isVazio(value)) {
                  return 'Campo cidade vazio !';
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
                  return 'Campo estado vazio !';
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
              titulo: 'Fornecedor',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/cadastrar_fornecedor',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/consultar_fornecedor',
            ),
            Expanded(
                child: SingleChildScrollView(
              // child: Expanded(
              child: Container(
                padding: paddingPadrao,
                child: Column(
                  children: [
                    MolduraComponent(
                      label: 'Fornecedor',
                      content: formFornecedor,
                    ),
                    MolduraComponent(
                      label: 'Endereço',
                      content: formEndereco,
                    ),
                    ButtonComponent(
                      label: 'Cadastrar',
                      onPressed: cadastrarFornecedor,
                    ),
                  ],
                ),
              ),
              // ),
            ))
          ],
        ),
      ),
    );
  }
}
