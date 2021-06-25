import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import '../homepage/homepage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKeyAutenticacao = GlobalKey<FormState>();

  autenticar() {
    Navigator.of(context).pushNamed('/pedido');
  }

  @override
  Widget build(BuildContext context) {
    final formAutenticacao = Form(
      key: _formKeyAutenticacao,
      child: Column(
        children: [
          InputComponent(
            label: 'Usuário: ',
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'Senha: ',
          ),
          SizedBox(height: 10),
          ButtonComponent(
            label: 'Entrar',
            onPressed: autenticar,
          ),
        ],
      ),
    );

    final cardAutenticacao = FormComponent(
      label: 'Login',
      content: formAutenticacao,
    );

    return MaterialApp(
      home: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            height: 73,
            decoration: BoxDecoration(color: colorAzul),
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(color: colorVermelho),
          ),
          SizedBox(
            height: 40.0,
          ),
          SingleChildScrollView(
            child: cardAutenticacao,
          ),
        ]),
      )),
    );
  }
}
