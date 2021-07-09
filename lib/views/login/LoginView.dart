import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/MoldulraComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/controllers/FuncionarioController.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKeyAutenticacao = GlobalKey<FormState>();
  bool isAutenticated = true;

  TextEditingController usuarioController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();

  autenticar(BuildContext context) async {
    if (_formKeyAutenticacao.currentState!.validate()) {
      FuncionarioController funcionarioController = new FuncionarioController();
      FuncionarioModel? funcionario = new FuncionarioModel();

      print(usuarioController.text);
      print(senhaController.text);

      //Chama a API para autenticação
      funcionario = await funcionarioController.autenticacao(
          usuarioController.text, senhaController.text);
      print(funcionario);
      if (funcionario == null) {
        //informa que está incorredo
        setState(() {
          isAutenticated = false;
        });
      } else {
        context
            .read<AutenticacaoModel>()
            .setFuncionario(funcionario);

        //caso seja autenticado, direciona para a rota subsequente
        Navigator.of(context).pushNamed('/pedido_venda_cadastrar');
      }
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
            validator: (value) {
              if (value == null || value == "") {
                return 'Campo obrigátorio!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          InputComponent(
            label: 'Senha: ',
            obscureText: false,
            controller: senhaController,
            validator: (value) {
              if (value == null || value == "") {
                return 'Campo obrigátorio!';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          ButtonComponent(
            label: 'Entrar',
            onPressed: () {
              autenticar(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          if (!isAutenticated)
            Container(
              child: TextComponent(
                label: 'Usuário ou senha incorretos',
                cor: colorVermelho,
              ),
            )
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
                  ))),
        ]),
      )),
    );
  }
}
