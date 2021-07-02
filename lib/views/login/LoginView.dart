import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/AutenticacaoController.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/services/Auth.dart';
import '../homepage/homepage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKeyAutenticacao = GlobalKey<FormState>();

  TextEditingController usuarioController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();

  autenticar() async {
    AutenticacaoController autenticacaoController = AutenticacaoController();

    AutenticacaoModel autenticacaoModel = await autenticacaoController.crie(
        usuarioController.text, senhaController.text);

    //Realiza o login
    Auth.login(autenticacaoModel.jwt!);

    if (Auth.isAuthenticated()) {
      Navigator.of(context).pushNamed('/pedido_venda_cadastrar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formAutenticacao = Form(
      key: _formKeyAutenticacao,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputComponent(
            label: 'Usuário: ',
            controller: usuarioController,
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'Senha: ',
            obscureText: true,
            controller: senhaController,
          ),
          SizedBox(height: 10),
          ButtonComponent(
            label: 'Entrar',
            onPressed: autenticar,
          ),
        ],
      ),
    );

    final cardAutenticacao = MolduraComponent(
      label: 'Login',
      content: formAutenticacao,
    );

    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: colorAzul),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: colorVermelho),
            ),
          ),
          Expanded(
              flex: 14,
              child: Container(
                  margin: marginPadrao,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [cardAutenticacao],
                  )))
        ]),
      )),
    );
  }
}
