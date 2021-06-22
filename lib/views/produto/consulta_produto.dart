import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/FormComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

class ProdutoConsultarView extends StatefulWidget {
  const ProdutoConsultarView({Key? key}) : super(key: key);

  @override
  _ProdutoConsultarViewState createState() => _ProdutoConsultarViewState();
}

class _ProdutoConsultarViewState extends State<ProdutoConsultarView> {
  final _formKeyConsultaProduto = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  /* final layoutVertical = Container(
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
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              children: [
                FormComponent(
                  label: 'Cliente',
                  content: formConsulta,
                ),
                FormComponent(
                  label: 'Clientes',
                  content: lista,
                ),
              ],
            ),
          ),
        ))
      ],
    ),
  );

  final layoutHorizontal = Container(
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
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormComponent(
                    label: 'Cliente',
                    content: formConsulta,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: FormComponent(
                    label: 'Clientes',
                    content: lista,
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    ),
  );
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: Container(
          child: Column(
            children: [
              SubMenuComponent(
                  titulo: 'Produto',
                  tituloPrimeiraRota: 'Cadastro',
                  primeiraRota: '/consulta_cliente',
                  tituloSegundaRota: 'Consulta',
                  segundaRota: '/consulta_cliente')
            ],
          ),
        ));
  }
}
