import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/input.dart';
import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/models/endereco.dart';
import 'package:projeto_flutter/services/apicorreios.dart';

//Mask
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../services/apicorreios.dart';

import '../../models/endereco.dart';

class Endereco extends StatefulWidget {
  Function changeEndereco;
  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  Endereco({Key? key, required this.changeEndereco}) : super(key: key);

  void handleSubmittedCep() async {
    var endereco = await getEndereco(
        UtilBrasilFields.removeCaracteres(cepController.text));

    //Seta valores nos campos de endereço
    logradouroController.text = endereco['logradouro'];
    complementoController.text = endereco['complemento'];
    bairroController.text = endereco['bairro'];
    cidadeController.text = endereco['localidade'];
    estadoController.text = endereco['uf'];

    //Cria objeto de endereco
    EnderecoModel enderecoModel = new EnderecoModel(
        cepController.text,
        logradouroController.text,
        complementoController.text,
        numeroController.text,
        bairroController.text,
        cidadeController.text,
        estadoController.text);

    this.changeEndereco(enderecoModel);
  }

  @override
  _EnderecoState createState() => _EnderecoState();
}

class _EnderecoState extends State<Endereco> {
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
            textEditingController: widget.cepController,
            handleSubmitted: widget.handleSubmittedCep),
        InputComponente(
            label: 'Logradouro',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: widget.logradouroController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Complemento',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: widget.complementoController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Bairro',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: widget.bairroController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Cidade',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: widget.cidadeController,
            handleSubmitted: () {}),
        InputComponente(
            label: 'Estado',
            maskFormatter: MaskTextInputFormatter(),
            filter: MaskTextInputFormatter(),
            textEditingController: widget.estadoController,
            handleSubmitted: () {}),
      ],
    );
  }
}
