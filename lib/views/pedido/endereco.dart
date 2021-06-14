import 'package:flutter/material.dart';

import 'package:projeto_flutter/componentes/textstyle.dart';

import 'package:projeto_flutter/services/apicorreios.dart';

//Mask
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

import '../../services/apicorreios.dart';

import '../../componentes/textstyle.dart';
import '../../componentes/inputdecoration.dart';
import '../../componentes/boxdecoration.dart';

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

  /*handleSubmittedCep() async {
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
*/
  @override
  _EnderecoState createState() => _EnderecoState();
}

class _EnderecoState extends State<Endereco> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
      padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
      decoration: boxDecorationComponente,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'CEP:',
                style: textStyleComponente,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 260,
                height: 31,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  decoration: inputDecorationComponente,
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                'Logradouro:',
                style: textStyleComponente,
              ),
              Container(
                margin: EdgeInsets.only(left: 3),
                width: 224,
                height: 31,
                child: TextField(
                  decoration: inputDecorationComponente,
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Num.:',
                    style: textStyleComponente,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 9),
                    width: 73,
                    height: 31,
                    child: TextField(
                      decoration: inputDecorationComponente,
                    ),
                  )
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Bairro:',
                      style: textStyleComponente,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      width: 128,
                      height: 31,
                      child: TextField(
                        decoration: inputDecorationComponente,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Cidade:',
                    style: textStyleComponente,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 1),
                    width: 115,
                    height: 31,
                    child: TextField(
                      decoration: inputDecorationComponente,
                    ),
                  )
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 14),
                child: Row(
                  children: [
                    Text(
                      'Estado:',
                      style: textStyleComponente,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      width: 73,
                      height: 31,
                      child: TextField(
                        decoration: inputDecorationComponente,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text('Entrega', style: textStyleComponente),
          Divider(),
          Text('CEP', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            controller: widget.cepController,
            onSubmitted: (text) {
              //widget.handleSubmittedCep();
            },
          ),
          Divider(),
          Text('Logradouro', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.logradouroController,
          ),
          Divider(),
          Text('Complemento', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.complementoController,
          ),
          Divider(),
          Text('Número', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.numeroController,
          ),
          Divider(),
          Text('Bairro', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.bairroController,
          ),
          Divider(),
          Text('Cidade', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.cidadeController,
          ),
          Divider(),
          Text('Estado', style: textStyleComponente),
          TextField(
            style: textStyleComponente,
            controller: widget.estadoController,
          ),
          Divider(),
        ],
      ),
    );
  }
}
