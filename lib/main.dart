import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/models/CarrinhoModel.dart';
import 'package:projeto_flutter/models/carrinhocompra.dart';
import 'package:projeto_flutter/views/cliente/cadastrar/ClienteCadastrarView.dart';
import 'package:projeto_flutter/views/cliente/consultar/ClienteConsultarView.dart';
import 'package:projeto_flutter/views/estoque/EstoqueView.dart';
import 'package:projeto_flutter/views/fornecedor/FornecedorCadastrarView.dart';
import 'package:projeto_flutter/views/fornecedor/FornecedorConsultarView.dart';
import 'package:projeto_flutter/views/pedido_Compra/consulta/PedidoCompraConsultaView.dart';
import 'package:projeto_flutter/views/pedido_compra/PedidoCompraCadastroView.dart';
import 'package:projeto_flutter/views/pedido_venda/cadastrar/PedidoVendaCadastrarView.dart';
import 'package:projeto_flutter/views/pedido_venda/consulta/PedidoVendaConsultaView.dart';
import 'package:projeto_flutter/views/produto/ProdutoCadastrarView.dart';
import 'package:projeto_flutter/views/produto/consulta_produto.dart';
import 'package:projeto_flutter/views/login/LoginView.dart';
import 'package:projeto_flutter/views/splash/splash_screen.dart';
import 'package:projeto_flutter/views/precificacao/precificacaoView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider<CarrinhoModel>(create: (_) => CarrinhoModel()),
      ListenableProvider<CarrinhoCompraModel>(create: (_) => CarrinhoCompraModel()),
      ListenableProvider<AutenticacaoModel>(create: (_) => AutenticacaoModel()),
    ],
    child: MyApp(),
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      initialRoute: '/pedido_venda_cadastrar',
      routes: {
        //'/': (context) => SplashPage(), //ok
        '/login': (context) => LoginView(), // ok
        '/pedido_venda_cadastrar': (context) => PedidoVendaCadastraView(),
        '/pedido_venda_consultar': (context) => PedidoVendaConsultaView(),
        '/cadastrar_cliente': (contexto) => ClienteCadastroView(),
        '/consultar_cliente': (contexto) => ClienteConsultaView(),
        '/cadastrar_fornecedor': (context) => FornecedorCadastrarView(),
        '/consultar_fornecedor': (context) => FornecedorConsultarView(),
        '/cadastrar_produto': (context) => ProdutoCadastrarView(),
        '/consultar_produto': (context) => ProdutoConsultarView(),
        '/pedido_compra_cadastrar': (contexto) => PedidoCompraCadastroView(),
        '/pedido_compra_consultar': (contexto) => PedidoCompraConsultaView(),
        '/estoque': (contexto) => EstoqueView(),
        '/cadastrar_precificacao': (context) => PrecificacaoView(),
      },
    );
  }
}
