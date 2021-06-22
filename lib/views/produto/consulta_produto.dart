import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/InputComponent.dart';

import 'package:projeto_flutter/componentes/SubMenuComponent.dart';

class ProdutoConsultarView extends StatefulWidget {
  const ProdutoConsultarView({Key? key}) : super(key: key);

  @override
  _ProdutoConsultarViewState createState() => _ProdutoConsultarViewState();
}

class _ProdutoConsultarViewState extends State<ProdutoConsultarView> {
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
                  primeiraRota: '/consulta_clinete',
                  tituloSegundaRota: 'Consulta',
                  segundaRota: '/consulta_cliente')
            ],
          ),
        ));
  }
}
