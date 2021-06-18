import 'package:flutter/material.dart';
import 'package:projeto_flutter/views/cliente/CadastroClienteView.dart';
import 'package:projeto_flutter/views/splash/splash_screen.dart';
// import 'package:projeto_flutter/views/pedido/pedido.dart';
import './views/login/login.dart';
// import './views/pedido/pedido.dart';
import 'package:projeto_flutter/views/cliente/CadastroClienteView.dart';
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
        '/': (context) => MySplashPage(),
        '/login': (context) => Login(),
        '/pedido': (context) => Pedido(),
        '/cadastrar_cliente': (contexto) => ClienteCadastroView(),
      },
    );
  }
}
