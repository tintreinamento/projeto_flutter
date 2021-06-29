import 'package:flutter/material.dart';
import 'package:projeto_flutter/views/pedido/consulta/PedidoConsultaView.dart';
import 'package:projeto_flutter/views/produto/consulta_produto.dart';
import 'package:projeto_flutter/views/login/LoginView.dart';
import 'package:projeto_flutter/views/pedido/PedidoView.dart';
import 'package:projeto_flutter/views/produto/ProdutoCadastrarView.dart';

import 'package:projeto_flutter/views/splash/splash_screen.dart';
// import 'package:projeto_flutter/views/pedido/pedido.dart';

// import './views/pedido/pedido.dart';
import 'package:projeto_flutter/views/cliente/ClienteCadastrarView.dart';
import 'package:projeto_flutter/views/cliente/ClienteConsultarView.dart';
import 'package:projeto_flutter/views/pedido/pedido.dart';

void main() {
  runApp(MyApp());
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        //'/': (context) => PedidoView(),
        '/': (context) => PedidoConsultaView(),
        //'/': (context) => SplashPage(),
        '/login': (context) => LoginView(),
        // '/pedido': (context) => Pedido(),
        '/cadastrar_cliente': (contexto) => ClienteCadastroView(),
        '/consultar_cliente': (contexto) => ClienteConsultarView(),
        // '/consultar_produto': (context) => ProdutoConsultarView(),
        // '/cadastrar_produto': (contexto) => ProdutoCadastrarView(),
      },
    );
  }
}
