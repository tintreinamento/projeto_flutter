import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/input.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/services/apicorreios.dart';

//Mask
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../services/apicorreios.dart';

class Endereco extends StatefulWidget {
  const Endereco({Key? key}) : super(key: key);

  @override
  _EnderecoState createState() => _EnderecoState();
}

class _EnderecoState extends State<Endereco> {
  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  void handleSubmittedCep() async {
    var endereco = await getEndereco(
        UtilBrasilFields.removeCaracteres(cepController.text));

    //Seta valores nos campos de endereço
    logradouroController.text = endereco['logradouro'];
    complementoController.text = endereco['complemento'];
    bairroController.text = endereco['bairro'];
    cidadeController.text = endereco['localidade'];
    estadoController.text = endereco['uf'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponente(label: 'Entrega'),
        Divider(),
        InputComponente(
            label: 'CEP',
            maskFormatter: CepInputFormatter(),
            filter: FilteringTextInputFormatter.digitsOnly,
            textEditingController: cepController,
            handleSubmitted: handleSubmittedCep),
        InputComponente(
            label: 'Logradouro',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: logradouroController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Complemento',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: complementoController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Bairro',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: bairroController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Cidade',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: cidadeController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Estado',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: estadoController,
            handleSubmitted: () {}),
      ],
    );
  }
}
