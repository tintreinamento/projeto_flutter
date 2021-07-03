import 'package:flutter/material.dart';
import 'package:projeto_flutter/models/CarrinhoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/views/cliente/cadastrar/ClienteCadastrarView.dart';
import 'package:projeto_flutter/views/cliente/consultar/ClienteConsultarView.dart';
import 'package:projeto_flutter/views/estoque/EstoqueView.dart';
import 'package:projeto_flutter/views/fornecedor/FornecedorCadastrarView.dart';
import 'package:projeto_flutter/views/fornecedor/FornecedorConsultarView.dart';
import 'package:projeto_flutter/views/pedido_venda/cadastrar/PedidoVendaCadastrarView.dart';
import 'package:projeto_flutter/views/pedido_venda/consulta/PedidoVendaConsultaView.dart';
import 'package:projeto_flutter/views/pedido_Compra/PedidoCompraCadastroView.dart';
import 'package:projeto_flutter/views/produto/consulta_produto.dart';
import 'package:projeto_flutter/views/login/LoginView.dart';
import 'package:projeto_flutter/views/produto/ProdutoCadastrarView.dart';
import 'package:projeto_flutter/views/splash/splash_screen.dart';
// import 'package:projeto_flutter/views/pedido/pedido.dart';
// import './views/pedido/pedido.dart';
import 'package:projeto_flutter/views/precificacao/precificacaoView.dart';

import 'package:provider/provider.dart';

// void main() {
//   runApp(MultiProvider(
//     providers: [ChangeNotifierProvider(create: (context) => CarrinhoModel())],
//     child: MyApp(),
//   ));
//   //runApp(MyApp());
// }

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
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/cadastrar_fornecedor',
      routes: {
        '/': (context) => PedidoVendaConsultaView(),
        //'/': (context) => SplashPage(), //ok
        //'/login': (context) => LoginView(), // ok
        '/pedido_venda_cadastrar': (context) => PedidoVendaCadastraView(),
        '/pedido_venda_consultar': (context) => PedidoVendaConsultaView(),
        '/cadastrar_cliente': (contexto) => ClienteCadastroView(),
        '/consultar_cliente': (contexto) => ClienteConsultarView(),
        '/cadastrar_fornecedor': (context) => FornecedorCadastrarView(),
        '/consultar_fornecedor': (context) => FornecedorConsultarView(),
        '/consultar_produto': (context) => ProdutoConsultarView(),
        '/cadastrar_produto': (contexto) => ProdutoCadastrarView(),
        //'/cadastrar_precificacao': (contexto) => PrecificacaoView(),
        //'/pedido_compra': (contexto) => PedidoCompraCadastroView(),
      },
    );
  }
}
