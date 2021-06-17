import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

import 'package:projeto_flutter/componentes/text.dart';
import 'package:projeto_flutter/componentes/textformfield.dart';

class ClienteCadastro extends StatefulWidget {
  const ClienteCadastro({Key? key}) : super(key: key);

  @override
  _ClienteCadastroState createState() => _ClienteCadastroState();
}

class _ClienteCadastroState extends State<ClienteCadastro> {
  final nomeController = TextEditingController();

  pegarNome() {
    print(nomeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: InputComponent(
          label: 'Nome completo',
          controller: nomeController,
          handleOnChange: pegarNome,
        ),
      ),
    );
  }
}
