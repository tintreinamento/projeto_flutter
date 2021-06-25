import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/Responsive.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/util/CarrinhoCompra.dart';
import 'package:projeto_flutter/views/pedido/FormCliente.dart';
import 'package:projeto_flutter/views/pedido/ProdutoCarrinhoWidget.dart';
import '../pedido/ListaProduto.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';

class PedidoTesteView extends StatefulWidget {
  BuildContext? context;

  PedidoTesteView({Key? key}) : super(key: key);

  @override
  _PedidoTesteViewState createState() => _PedidoTesteViewState();
}

class _PedidoTesteViewState extends State<PedidoTesteView> {
  bool _active = false;
  abrirCarrinhoCompra() {
    print("teste");
    setState(() {
      this._active = !this._active;
    });
  }

  confirmarPedido() async {
    //  if (FormCliente.formKeyCliente.currentState!.validate()) {

    //Pedido
    PedidoModel pedidoModel = new PedidoModel(
        idCliente: 100,
        idFuncionario: 1,
        data: DateTime.now().toString(),
        total: widget.context!.read<CarrinhoCompra>().getTotal());

    PedidoController pedidoController = PedidoController();
    PedidoModel pedido = await pedidoController.crie(pedidoModel);

    print(pedido.id);

    //  var cliente = context!.read<CarrinhoCompra>().cliente;
    // var itemCarrinho = context!.read<CarrinhoCompra>().itemCarrinho;
    //  }

    // FormCliente.formKeyCliente.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    final carrinhoCompra = context.watch<CarrinhoCompra>();

    var size = MediaQuery.of(context).size;

    return ResponsiveComponent(
      mobile: Scaffold(
        appBar: AppBarComponent(),
        body: Column(
          children: [
            SubMenuComponent(
                titulo: 'Pedido',
                tituloPrimeiraRota: 'Cadastrar',
                primeiraRota: '/pedido_cadastrar',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/pedido_consultar'),
            SizedBox(
                height: size.height * 0.80,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: size.height, child: FormCliente()),
                          SizedBox(
                              height: size.height * 0.70,
                              child: ListaProduto()),
                        ],
                      ),
                    ),
                    ProdutoCarrinhoWidget(
                      active: _active,
                    )
                  ],
                )),
            Expanded(
                child: Cart(
              abrirCarrinhoCompra: abrirCarrinhoCompra,
              confirmarPedido: confirmarPedido,
            )),
          ],
        ),
      ),
      tablet: Scaffold(
          appBar: AppBarComponent(),
          body: Container(
            child: Column(
              children: [
                SubMenuComponent(
                    titulo: 'Pedido',
                    tituloPrimeiraRota: 'Cadastrar',
                    primeiraRota: '/pedido_cadastrar',
                    tituloSegundaRota: 'Consultar',
                    segundaRota: '/pedido_consultar'),
                Expanded(
                    child: Row(
                  children: [
                    SizedBox(
                      width: size.width / 2,
                      child: FormCliente(),
                    ),
                    SizedBox(
                      width: size.width / 2,
                      child: ListaProduto(),
                    ),
                  ],
                )),
              ],
            ),
          )),
      desktop: Scaffold(
        appBar: AppBarComponent(),
        body: Column(
          children: [
            SubMenuComponent(
                titulo: 'Pedido',
                tituloPrimeiraRota: 'Cadastrar',
                primeiraRota: '/pedido_cadastrar',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/pedido_consultar'),
            Expanded(
              child: ListaProduto(),
            ),
          ],
        ),
      ),
    );
  }
}

class Cart extends StatefulWidget {
  Function? confirmarPedido;
  Function? abrirCarrinhoCompra;
  Cart({Key? key, this.confirmarPedido, this.abrirCarrinhoCompra})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var formatoPreco = NumberFormat("#,##0.00", "pt_BR");
  @override
  Widget build(BuildContext context) {
    final carrinhoCompra = context.watch<CarrinhoCompra>();

    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            widget.abrirCarrinhoCompra!();
          },
          child: Align(
              alignment: Alignment.center,
              child: Text(
                'Por' +
                    'R\$ ' +
                    formatoPreco.format(carrinhoCompra.getTotal()).toString(),
              )),
        )),
        Expanded(
            child: ButtomCartCustom(
          confirmarPedido: widget.confirmarPedido,
        ))
      ],
    );
  }
}

class ButtomCartCustom extends StatelessWidget {
  Function? confirmarPedido;

  ButtomCartCustom({Key? key, this.confirmarPedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        confirmarPedido!();
      },
      child: Container(
          color: colorVerde,
          child: Image(
            image: AssetImage('assets/images/cart.png'),
          )),
    );
  }
}
