import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DropDownComponent.dart';

import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/TextFormFieldComponent.dart';
import 'package:projeto_flutter/componentes/inputDropDownComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/EnderecoCorreioController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoCorreioModel.dart';

class ClienteCadastroView extends StatefulWidget {
  const ClienteCadastroView({Key? key}) : super(key: key);

  @override
  _ClienteCadastroViewState createState() => _ClienteCadastroViewState();
}

class _ClienteCadastroViewState extends State<ClienteCadastroView> {
  final _formKeyCliente = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();

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

  bool isVazio(value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  int getSexo(value) {
    int sexo = 0;
    switch (value) {
      case "Masculino":
        sexo = 1;
        break;
      case "Feminino":
        sexo = 2;
        break;
      default:
    }
    return sexo;
  }

  selectSexo(value) {
    setState(() {
      sexoController.text = value;
    });
  }

  selectEstadoCivel(value) {
    setState(() {
      estadoCivilController.text = value;
    });
  }

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

  exibirData() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        dataNascimentoController.text = UtilData.obterDataDDMMAAAA(value!);
      });
    });
  }

  int getEstadoCivil(value) {
    int estadoCivil = 0;
    switch (value) {
      case "Solteiro":
        estadoCivil = 1;
        break;
      case "Casado":
        estadoCivil = 2;
        break;
      case "Divorciado":
        estadoCivil = 2;
        break;
      case "Viuvo":
        estadoCivil = 2;
        break;
      default:
    }

    return estadoCivil;
  }

  cadastrarCliente() async {
    if (_formKeyCliente.currentState!.validate()) {
      if (_formKeyEndereco.currentState!.validate()) {
        //Cadastrar os dados na API
        ClienteController clienteController = new ClienteController();

        var telefone =
            UtilBrasilFields.removeCaracteres(telefoneController.text);
        var ddd = telefone.substring(0, 2);
        var numeroTelefone = telefone.substring(2, telefone.length - 1);

        ClienteModel clienteModel = new ClienteModel(
            nome: nomeController.text,
            cpf: int.parse(
                UtilBrasilFields.removeCaracteres(cpfCnpjController.text)),
            dataNascimento: dataNascimentoController.text,
            estadoCivil: getEstadoCivil(estadoCivilController.text),
            email: emailController.text,
            sexo: getSexo(sexoController.text),
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
        showDialog();
      }
    }
  }

  showDialog() {
    return AlertDialog(
      actions: [
        Column(children: [
          Text('Cliente cadastrado com sucesso !'),
          Container(
            width: 241,
            height: 31,
            margin: EdgeInsets.only(top: 18, bottom: 13),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(0, 94, 181, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    estadoCivilController.text = "Selecione o estado cívil";
    sexoController.text = "Selecione o sexo";
  }

  @override
  Widget build(BuildContext context) {
    final formCliente = Form(
      key: _formKeyCliente,
      child: Wrap(
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
          InputComponent(
            label: 'CPF/CNPJ: ',
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              CpfOuCnpjFormatter()
            ],
            controller: cpfCnpjController,
            // validator: validarCpfCnpj,
          ),
          Expanded(
              child: InputDropDownComponent(
            label: 'Estado cívil: ',
            labelDropDown: estadoCivilController.text,
            items: ['Solteiro', 'Casado', 'Divorciado', 'Viuvo'],
            onChanged: selectEstadoCivel,
          )),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextComponent(
                    label: 'Data de nascimento: ',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                      controller: dataNascimentoController,
                      validator: (value) {
                        if (isVazio(value)) {
                          return 'Campo data de nascimento vazio !';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 10, top: 15, bottom: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(191, 188, 188, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(191, 188, 188, 1))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 15), // add padding to adjust icon
                          child: FlatButton(
                              onPressed: exibirData,
                              child: Icon(
                                Icons.calendar_today,
                                color: colorAzul,
                              )),
                        ),
                      )),
                )
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: Row(
          //       children: [
          //         Expanded(
          //           child: InputComponent(
          //             label: 'Data de nascimento: ',
          //             inputFormatter: [
          //               FilteringTextInputFormatter.digitsOnly,
          //               DataInputFormatter()
          //             ],
          //             controller: dataNascimentoController,
          //             validator: (value) {
          //               if (isVazio(value)) {
          //                 return 'Campo data de nascimento vazio !';
          //               }
          //               return null;
          //             },
          //           ),
          //         ),
          //       ],
          //     ))
          //   ],
          // ),
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
          Expanded(
              child: InputDropDownComponent(
            label: 'Sexo: ',
            labelDropDown: sexoController.text,
            items: [
              'Masculino',
              'Feminino',
            ],
            onChanged: selectSexo,
          )),
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

    final formEndereco = Container(
      child: Form(
        key: _formKeyEndereco,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                titulo: 'Cliente',
                tituloPrimeiraRota: 'Cadastro',
                primeiraRota: '/cadastrar_cliente',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/consultar_cliente',
              ),
              Expanded(
                  flex: 15,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: paddingPadrao,
                      child: Column(
                        children: [
                          MolduraComponent(
                            label: 'Cliente',
                            content: formCliente,
                          ),
                          MolduraComponent(
                            label: 'Endereco',
                            content: formEndereco,
                          ),
                          ButtonComponent(
                            label: 'Cadastrar',
                            onPressed: cadastrarCliente,
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
