import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/controllers/EnderecoController.dart';
import 'package:projeto_flutter/controllers/FornecedorController.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
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

  //Dados de cliente
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

  String validarCpfCnpj(cpfCnpj) {
    if (isVazio(cpfCnpj)) {
      return 'Campo CPF/CNPJ vazio';
    }
    if (UtilBrasilFields.removeCaracteres(cpfCnpj).length == 11) {
      if (UtilBrasilFields.isCPFValido(
          UtilBrasilFields.removeCaracteres(cpfCnpj))) {
        return 'CPF inválido !';
      }
    }
    if (UtilBrasilFields.removeCaracteres(cpfCnpj).length == 14) {
      if (UtilBrasilFields.isCNPJValido(cpfCnpj)) {
        return 'CNPJ inválido !';
      }
    }
    return "";
  }

  cadastrarFornecedor() {
    if (_formKeyFornecedor.currentState!.validate()) {
      if (_formKeyEndereco.currentState!.validate()) {
        //Cadastrar os dados na API

        FornecedorModel fornecedorModel = FornecedorModel(
            nome: nomeController.text,
            cpfCnpj: UtilBrasilFields.removeCaracteres(cpfCnpjController.text),
            email: emailController.text,
            telefone:
                UtilBrasilFields.removeCaracteres(telefoneController.text));
        EnderecoModel enderecoModel = EnderecoModel(
            cep: UtilBrasilFields.removeCaracteres(cepController.text),
            logradouro: logradouroController.text,
            numero: numeroController.text,
            bairro: bairroController.text);

        FornecedorController fornecedorController = FornecedorController();
        fornecedorController.crie(fornecedorModel);
        EnderecoController enderecoController = EnderecoController();
        enderecoController.crie(enderecoModel);
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
            controller: emailController,
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

    final formEndereco = Container(
      child: Form(
        key: _formKeyEndereco,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputComponent(
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
                      FormComponent(
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
              ))
            ],
          ),
        ));
  }
}
