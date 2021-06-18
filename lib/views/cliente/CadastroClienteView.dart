import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/CardComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

import 'package:projeto_flutter/componentes/TextComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class ClienteCadastroView extends StatefulWidget {
  const ClienteCadastroView({Key? key}) : super(key: key);

  @override
  _ClienteCadastroViewState createState() => _ClienteCadastroViewState();
}

class _ClienteCadastroViewState extends State<ClienteCadastroView> {
  final _formKeyCliente = GlobalKey<FormState>();

  //Dados de cliente
  final nomeController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final estadoCivilController = TextEditingController();
  final dataNascimento = TextEditingController();
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

  isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String validarCpfCnpj(cpfCnpj) {
    if (!isVazio(cpfCnpj)) {
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

  cadastrarCliente() {
    if (_formKeyCliente.currentState!.validate()) {
      //Cadastrar os dados na API
    }
  }

  @override
  Widget build(BuildContext context) {
    final formCliente = Form(
      key: _formKeyCliente,
      child: Column(
        children: [
          Flexible(
            child: InputComponent(
              label: 'CPF/CNPJ: ',
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                CpfOuCnpjFormatter()
              ],
              controller: cpfCnpjController,
              validator: validarCpfCnpj,
            ),
          ),
          ButtonComponent(
            label: 'Teste',
            onPressed: cadastrarCliente,
          )
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
              titulo: 'Cliente',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: 'cadastrao_cliente',
              tituloSegundaRota: 'Consultar',
              segundaRota: 'consultar_cliente',
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Flexible(
                      child: CardComponent(
                        label: 'Cliente',
                        content: formCliente,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
