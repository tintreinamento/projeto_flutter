import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';


import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';

import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/EnderecoCorreioController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';

import 'package:select_form_field/select_form_field.dart';

class ClienteCadastroView extends StatefulWidget {
  const ClienteCadastroView({Key? key}) : super(key: key);

  @override
  _ClienteCadastroViewState createState() => _ClienteCadastroViewState();
}

class _ClienteCadastroViewState extends State<ClienteCadastroView> {
  final List<Map<String, dynamic>> _itemsEstadoCivil = [
    {
      'value': '1',
      'label': 'Solteiro',
    },
    {
      'value': '2',
      'label': 'Casado',
    },
    {
      'value': '3',
      'label': 'Divorciado',
    },
    {
      'value': '4',
      'label': 'Viúvo',
    },
  ];
  final List<Map<String, dynamic>> _itemsSexo = [
    {'value': '1', 'label': 'Feminino'},
    {'value': '2', 'label': 'Masculino'}
  ];

  final _formKeyCliente = GlobalKey<FormState>();


  //Dados de cliente
  final nomeController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final estadoCivilController = TextEditingController();

  final emailController = TextEditingController();
  final sexoController = TextEditingController();
  final dddController = TextEditingController();
  final telefoneController = TextEditingController();

  //Dados de endereço
  final cepController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();

  carregarEndereco() async {
    EnderecoCorreioController enderecoCorreioController =
        new EnderecoCorreioController();
    final enderecoCorreioModel =
        await enderecoCorreioController.obtenhaEnderecoPorCep(
            UtilBrasilFields.removeCaracteres(cepController.text));

    //Carrega os dados de endereço
    logradouroController.text = enderecoCorreioModel.logradouro;
    bairroController.text = enderecoCorreioModel.bairro;
    cidadeController.text = enderecoCorreioModel.localidade;
    estadoController.text = enderecoCorreioModel.uf;
  }

  exibirData(context) {
    showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 01, 01),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        dataNascimentoController.text = UtilData.obterDataDDMMAAAA(value!);
      });
    });
  }

  cadastrarCliente(BuildContext context) async {
    if (_formKeyCliente.currentState!.validate()) {
      //Cadastrar os dados na API
      ClienteController clienteController = new ClienteController();
      //Verifica se existe cliente cadastrado com o mesmo CPF/CNPJ
      ClienteModel? cliente = await clienteController.obtenhaPorCpf(
          UtilBrasilFields.removeCaracteres(cpfCnpjController.text));

      if (cliente != null) {
        _showDialog(context, 'CPF ou CNPJ cadastrado na base de dados!');
        return;
      } else {
        var telefone =
            UtilBrasilFields.removeCaracteres(telefoneController.text);
        var ddd = telefone.substring(0, 2);
        var numeroTelefone = telefone.substring(2, telefone.length - 1);

        //Monta o modelo do cliente
        ClienteModel clienteModel = new ClienteModel(
            nome: nomeController.text,
            cpf: int.parse(
                UtilBrasilFields.removeCaracteres(cpfCnpjController.text)),
            dataNascimento: dataNascimentoController.text,
            estadoCivil: int.parse(estadoCivilController.text),
            email: emailController.text,
            sexo: int.parse(sexoController.text),
            ddd: ddd,
            numeroTelefone: numeroTelefone,
            logradouro: logradouroController.text,
            numero: int.parse(numeroController.text),
            bairro: bairroController.text,
            cidade: cidadeController.text,
            cep: int.parse(
                UtilBrasilFields.removeCaracteres(cepController.text)),
            uf: estadoController.text);

        //Cria o cliente
        var clienteRetorno = await clienteController.crie(clienteModel);
        print(clienteRetorno.nome);
        print('teste');

        //Limpa os campos do formúlario
        _formKeyCliente.currentState!.reset();
        _showDialog(context, 'Cliente cadastrado com sucesso !');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBarComponent(),
      drawer: DrawerComponent(),
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            SubMenuComponent(
              titulo: 'Cliente',
              tituloPrimeiraRota: 'Cadastro',
              primeiraRota: '/cadastrar_cliente',
              tituloSegundaRota: 'Consultar',
              segundaRota: '/consultar_cliente',
            ),
            Expanded(
              child: Container(
                width: mediaQuery.size.width,
                padding: paddingPadrao,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.0),
                      Form(
                        key: _formKeyCliente,
                        child: Column(
                          children: [
                            MolduraComponent(
                              label: 'Cliente',
                              content: Column(
                                children: [
                                  InputComponent(
                                    label: 'Nome: ',
                                    controller: nomeController,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[a-zA-Z]+|\s")),
                                    ],
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigatório!';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'CPF/CNPJ: ',
                                    controller: cpfCnpjController,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CpfOuCnpjFormatter()
                                    ],
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }

                                      if (UtilBrasilFields.removeCaracteres(
                                                      value)
                                                  .length !=
                                              11 &&
                                          UtilBrasilFields.removeCaracteres(
                                                      value)
                                                  .length !=
                                              14) {
                                        return 'Formato de CPF ou CNPJ inválido';
                                      }
                                      if (UtilBrasilFields.removeCaracteres(
                                                  value)
                                              .length ==
                                          11) {
                                        if (!UtilBrasilFields.isCPFValido(
                                            UtilBrasilFields.removeCaracteres(
                                                value))) {
                                          return 'Informe um CPF válido !';
                                        }
                                      }
                                      if (UtilBrasilFields.removeCaracteres(
                                                  value)
                                              .length ==
                                          14) {
                                        if (!UtilBrasilFields.isCNPJValido(
                                            UtilBrasilFields.removeCaracteres(
                                                value))) {
                                          return 'Informe um CNPJ válido !';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.15,
                                        child: TextComponent(
                                          label: 'Estado Civil: ',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: SelectFormField(
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 15,
                                                    bottom: 15),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            191, 188, 188, 1))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            191, 188, 188, 1))),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                suffixIcon: Container(
                                                  child: Icon(
                                                      Icons.arrow_drop_down),
                                                )),
                                            labelText:
                                                'Selecione o estado civil',
                                            type: SelectFormFieldType
                                                .dropdown, // or can be dialog

                                            items: _itemsEstadoCivil,
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return 'Campo obrigatório!';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              estadoCivilController.text =
                                                  value;
                                            },
                                            onSaved: (value) => print(value)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.15,
                                        child: TextComponent(
                                          label: 'Data de nascimento: ',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                            controller:
                                                dataNascimentoController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return 'Campo obrigátorio!';
                                              }

                                              DateTime dataAtual =
                                                  DateTime.now();

                                              String dataInformada =
                                                  UtilBrasilFields
                                                      .removeCaracteres(value);

                                              int ano = int.parse(dataInformada
                                                  .substring(4, 8));
                                              int mes = int.parse(dataInformada
                                                  .substring(2, 4));
                                              int dia = int.parse(dataInformada
                                                  .substring(0, 2));

                                              if (mes > 12) {
                                                return 'Data de nascimento com mês inválido !';
                                              }

                                              if (dia > 31) {
                                                return 'Data de nascimento com dia inválido !';
                                              }

                                              DateTime dataInformadaFormatada =
                                                  DateTime(ano, mes, dia);

                                              print(dataAtual);
                                              print(dataInformadaFormatada);

                                              if (dataAtual
                                                  .difference(
                                                      dataInformadaFormatada)
                                                  .isNegative) {
                                                return 'Data de nascimento superior ao calendário atual !';
                                              }

                                              if (DateTime.now()
                                                      .difference(
                                                          dataInformadaFormatada)
                                                      .inDays >
                                                  (120 * 365)) {
                                                return 'Data de nascimento superior a expectativa de vida humana !';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              DataInputFormatter()
                                            ],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, top: 5, bottom: 15),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          191, 188, 188, 1))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          191, 188, 188, 1))),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                ), // add padding to adjust icon
                                                child: SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: TextButton(
                                                      onPressed: () =>
                                                          exibirData(context),
                                                      child: Icon(
                                                        Icons.calendar_today,
                                                        color: colorAzul,
                                                      )),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.15,
                                        child: TextComponent(
                                          label: 'Sexo: ',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: SelectFormField(
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 15,
                                                    bottom: 15),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            191, 188, 188, 1))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    191,
                                                                    188,
                                                                    188,
                                                                    1))),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                suffixIcon: Container(
                                                  child: Icon(
                                                      Icons.arrow_drop_down),
                                                )),
                                            labelText: 'Selecione o sexo',
                                            type: SelectFormFieldType
                                                .dropdown, // or can be dialog

                                            items: _itemsSexo,
                                            validator: (value) {
                                              if (value == null ||
                                                  value == "") {
                                                return 'Campo obrigátorio!';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              sexoController.text = value;
                                            },
                                            onSaved: (value) => print(value)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InputComponent(
                                    label: 'E-mail: ',
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      if (Validator.email(value)) {
                                        return 'E-mail inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter()
                                    ],
                                    label: 'Telefone: ',
                                    controller: telefoneController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            MolduraComponent(
                              label: 'Endereço',
                              content: Column(
                                children: [
                                  InputComponent(
                                    label: 'CEP: ',
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CepInputFormatter()
                                    ],
                                    onFieldSubmitted: carregarEndereco,
                                    controller: cepController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      if (UtilBrasilFields.removeCaracteres(
                                                  value)
                                              .length !=
                                          8) {
                                        return 'CEP inválido';
                                      }
                                      if (Validator.cep(
                                          UtilBrasilFields.obterCep(
                                              UtilBrasilFields.removeCaracteres(
                                                  value),
                                              ponto: false))) {
                                        return 'CEP inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'Logradouro: ',
                                    controller: logradouroController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'Número: ',
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: numeroController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'Bairro: ',
                                    controller: bairroController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'Cidade: ',
                                    controller: cidadeController,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[a-zA-Z]+|\s")),
                                    ],
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                  InputComponent(
                                    label: 'Estado: ',
                                    controller: estadoController,
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[a-zA-Z]+|\s")),
                                    ],
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return 'Campo obrigátorio!';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonComponent(
                        label: 'Cadastrar',
                        onPressed: () => cadastrarCliente(context),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_showDialog(context, info) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Column(children: [
              TextComponent(
                label: info.toString(),
              ),
              Container(
                width: 241,
                height: 31,
                margin: EdgeInsets.only(top: 18, bottom: 13),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(0, 94, 181, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Confirmar pedido',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    )),
              )
            ])
          ],
        );
      });
}
