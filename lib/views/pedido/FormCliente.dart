import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/Responsive.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/EnderecoCorreioController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoCorreioModel.dart';
import 'package:projeto_flutter/util/CarrinhoCompra.dart';
import 'package:provider/provider.dart';

class FormCliente extends StatelessWidget {
  BuildContext? context;
  static final formKeyCliente = GlobalKey<FormState>();
  ClienteModel cliente = new ClienteModel();
//   ClienteModel? cliente;
  FormCliente({Key? key}) : super(key: key);

  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();

  //Endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  carregarCliente(cpfCnpj) async {
    ClienteController clienteController = new ClienteController();
    cliente = await clienteController
        .obtenhaPorCpf(UtilBrasilFields.removeCaracteres(cpfCnpj));
    //Preenche o nome do cliente
    nomeClienteController.text = cliente!.nome;

    //Preenche os dados de endereço do cliente!.
    cepController.text = UtilBrasilFields.obterCep(cliente!.cep);
    logradouroController.text = cliente!.logradouro;
    numeroController.text = cliente!.numero.toString();
    bairroController.text = cliente!.bairro;
    cidadeController.text = cliente!.cidade;
    estadoController.text = cliente!.uf;
    setCliente();
  }

  carregarEndereco(cep) async {
    EnderecoCorreioController enderecoCorreioController =
        new EnderecoCorreioController();
    final enderecoCorreioModel = await enderecoCorreioController
        .obtenhaEnderecoPorCep(UtilBrasilFields.removeCaracteres(cep));

    //Carrega os dados de endereço
    logradouroController.text = enderecoCorreioModel.logradouro;
    bairroController.text = enderecoCorreioModel.bairro;
    cidadeController.text = enderecoCorreioModel.localidade;
    estadoController.text = enderecoCorreioModel.uf;

    //Atualiza o endereço
    cliente!.cep = UtilBrasilFields.removeCaracteres(cep);
    cliente!.logradouro = logradouroController.text;
    cliente!.bairro = bairroController.text;
    cliente!.cidade = cidadeController.text;
    cliente!.uf = estadoController.text;
    setCliente();
  }

  setCliente() {
    context!.read<CarrinhoCompra>().cliente = this.cliente;
  }

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

  @override
  Widget build(BuildContext context) {
    this.context = context;

    var layoutFormCliente;
    //Se a orientação for igual a mobile
    //if (ResponsiveComponent.isMobile(context)) {
    layoutFormCliente = Form(
      key: formKeyCliente,
      child: Column(
        children: [
          InputComponent(
            label: 'CPF/CNPJ: ',
            controller: cpfCnpjController,
            onFieldSubmitted: carregarCliente,
            validator: (cpfCnpj) {
              return isCpfCnpjValidator(cpfCnpj);
            },
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              CpfOuCnpjFormatter()
            ],
          ),
          InputComponent(
            label: 'Nome: ',
            controller: nomeClienteController,
            validator: (value) {
              return isEmpty(value);
            },
          ),
          InputComponent(
            label: 'CEP: ',
            controller: cepController,
            onFieldSubmitted: carregarEndereco,
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
    );
    // }
    return Container(
      child: layoutFormCliente,
    );
  }
}

// class FormCliente extends StatefulWidget {
//   GlobalKey<FormState> _formKeyCliente = GlobalKey<FormState>();
//   ClienteModel? cliente;

//   FormCliente({Key? key}) : super(key: key);

//    bool isDesktop(BuildContext context) {
//     return _formKeyCliente.currentState!.validate();
//   }

//   @override
//   _FormClienteState createState() => _FormClienteState();
// }

// class _FormClienteState extends State<FormCliente> {
//   TextEditingController cpfCnpjController = TextEditingController();
//   TextEditingController nomeClienteController = TextEditingController();

//   //Endereço
//   TextEditingController cepController = TextEditingController();
//   TextEditingController logradouroController = TextEditingController();
//   TextEditingController complementoController = TextEditingController();
//   TextEditingController numeroController = TextEditingController();
//   TextEditingController bairroController = TextEditingController();
//   TextEditingController cidadeController = TextEditingController();
//   TextEditingController estadoController = TextEditingController();

//   carregarCliente(cpfCnpj) async {
//     ClienteController clienteController = new ClienteController();
//     widget.cliente = await clienteController
//         .obtenhaPorCpf(UtilBrasilFields.removeCaracteres(cpfCnpj));
//     //Preenche o nome do cliente
//     nomeClienteController.text = widget.cliente!.nome;

//     //Preenche os dados de endereço do widget.cliente!.
//     cepController.text = UtilBrasilFields.obterCep(widget.cliente!.cep);
//     logradouroController.text = widget.cliente!.logradouro;
//     numeroController.text = widget.cliente!.numero.toString();
//     bairroController.text = widget.cliente!.bairro;
//     cidadeController.text = widget.cliente!.cidade;
//     estadoController.text = widget.cliente!.uf;
//   }

//   carregarEndereco(cep) async {
//     EnderecoCorreioController enderecoCorreioController =
//         new EnderecoCorreioController();
//     final enderecoCorreioModel = await enderecoCorreioController
//         .obtenhaEnderecoPorCep(UtilBrasilFields.removeCaracteres(cep));

//     //Carrega os dados de endereço
//     logradouroController.text = enderecoCorreioModel.logradouro;
//     bairroController.text = enderecoCorreioModel.bairro;
//     cidadeController.text = enderecoCorreioModel.localidade;
//     estadoController.text = enderecoCorreioModel.uf;

//     //Atualiza o endereço
//     widget.cliente!.cep = UtilBrasilFields.removeCaracteres(cep);
//     widget.cliente!.logradouro = logradouroController.text;
//     widget.cliente!.bairro = bairroController.text;
//     widget.cliente!.cidade = cidadeController.text;
//     widget.cliente!.uf = estadoController.text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var layoutFormCliente;
//     //Se a orientação for igual a mobile
//     //if (ResponsiveComponent.isMobile(context)) {
//     layoutFormCliente = Form(
//       key: widget._formKeyCliente,
//       child: Column(
//         children: [
//           InputComponent(
//             label: 'CPF/CNPJ: ',
//             controller: cpfCnpjController,
//             onFieldSubmitted: carregarCliente,
//             inputFormatter: [
//               FilteringTextInputFormatter.digitsOnly,
//               CpfOuCnpjFormatter()
//             ],
//           ),
//           InputComponent(
//             label: 'Nome: ',
//             controller: nomeClienteController,
//           ),
//           InputComponent(
//             label: 'CEP: ',
//             controller: cepController,
//             onFieldSubmitted: carregarEndereco,
//             inputFormatter: [
//               FilteringTextInputFormatter.digitsOnly,
//               CepInputFormatter()
//             ],
//           ),
//           InputComponent(
//             label: 'Logradouro: ',
//             controller: logradouroController,
//           ),
//           InputComponent(
//             label: 'Complemento: ',
//             controller: complementoController,
//           ),
//           InputComponent(
//             label: 'Número: ',
//             controller: numeroController,
//           ),
//           InputComponent(
//             label: 'Bairro: ',
//             controller: bairroController,
//           ),
//           InputComponent(
//             label: 'Cidade: ',
//             controller: cidadeController,
//           ),
//           InputComponent(
//             label: 'Estado: ',
//             controller: estadoController,
//           ),
//         ],
//       ),
//     );
//     // }
//     return Container(
//       child: layoutFormCliente,
//     );
//   }
// }
