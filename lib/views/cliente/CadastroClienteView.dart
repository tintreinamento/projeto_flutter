import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/CardComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';

import 'package:projeto_flutter/componentes/TextComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

class ClienteCadastroView extends StatefulWidget {
  const ClienteCadastroView({Key? key}) : super(key: key);

  @override
  _ClienteCadastroViewState createState() => _ClienteCadastroViewState();
}

class _ClienteCadastroViewState extends State<ClienteCadastroView> {
  final nomeController = TextEditingController();

  pegarNome() {
    print(nomeController.text);
  }

  pegaraNome(text) {
    print(nomeController.text);
  }

  @override
  Widget build(BuildContext context) {
    final context = Column(
      children: [
        Flexible(
          child: InputComponent(
            label: 'Nome',
          ),
        ),
        ButtonComponent(
          label: 'Teste',
        )
      ],
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
              child: CardComponent(
                label: 'TESTE',
                content: context,
              ),
            )
          ],
        ),
      ),
    );
  }
}
