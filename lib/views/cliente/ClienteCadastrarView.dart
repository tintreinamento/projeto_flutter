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
  final estadoCivilController = TextEditingController();
  final dataNascimentoController = TextEditingController();
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

  limparCampos() {
    //Dados de cliente
    nomeController.text = '';
    cpfCnpjController.text = '';
    estadoCivilController.text = '';
    dataNascimentoController.text = '';
    emailController.text = '';
    sexoController.text = '';
    dddController.text = '';
    telefoneController.text = '';

    //Dados de endereço
    cepController.text = '';
    logradouroController.text = '';
    numeroController.text = '';
    bairroController.text = '';
    cidadeController.text = '';
    estadoController.text = '';
  }

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

  selectEstadoCivel(value) {
    estadoCivilController.text = value;
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
        dataNascimentoController.text = value.toString();
      });
    });
  }

  cadastrarCliente() async {
    // if (_formKeyCliente.currentState!.validate()) {
    //  if (_formKeyEndereco.currentState!.validate()) {
    //Cadastrar os dados na API

    ClienteModel clienteModel = ClienteModel(
        nome: nomeController.text,
        cpf: UtilBrasilFields.removeCaracteres(cpfCnpjController.text),
        email: emailController.text,
        //dataNascimento:
        // UtilBrasilFields.removeCaracteres(dataNascimentoController.text),
        estadoCivil: estadoCivilController.text,
        sexo: sexoController.text,
        ddd: dddController.text,
        numeroTelefone:
            UtilBrasilFields.removeCaracteres(telefoneController.text),
        cep: UtilBrasilFields.removeCaracteres(cepController.text),
        logradouro: logradouroController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        uf: estadoController.text);

    ClienteController clienteController = ClienteController();

    var teste = await clienteController.crie(clienteModel);
    print(teste);
    limparCampos();
    showDialog();
    // }
    //}
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
  Widget build(BuildContext context) {
    final formCliente = Form(
      key: _formKeyCliente,
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
          Row(
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 260.0),
                  child: InputDropDownComponent(
                    label: 'Estado cível: ',
                    labelDropDown: 'Selecione o estado cível',
                    items: ['Solteiro', 'Casado', 'Divorciado', 'Viuvo'],
                    onChanged: selectEstadoCivel,
                  )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'Data de nascimento: ',
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      controller: dataNascimentoController,
                      validator: (value) {
                        if (isVazio(value)) {
                          return 'Campo data de nascimento vazio !';
                        }
                        return null;
                      },
                    ),
                  ),
                  FlatButton(
                      onPressed: exibirData,
                      child: Icon(
                        Icons.calendar_today,
                        color: colorAzul,
                      ))
                ],
              ))
            ],
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
                  child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    children: [
                      FormComponent(
                        label: 'Cliente',
                        content: formCliente,
                      ),
                      FormComponent(
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
