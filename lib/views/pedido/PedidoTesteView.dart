import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_flutter/componentes/AppBarComponent.dart';
import 'package:projeto_flutter/componentes/ButtonComponent.dart';
import 'package:projeto_flutter/componentes/DrawerComponent.dart';
import 'package:projeto_flutter/componentes/Responsive.dart';
import 'package:projeto_flutter/componentes/SubMenuComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';
import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/ItemPedidoController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/util/CarrinhoCompra.dart';
import 'package:projeto_flutter/util/ItemCarrinho.dart';
import 'package:projeto_flutter/views/pedido/FormCliente.dart';
import 'package:projeto_flutter/views/pedido/ProdutoCarrinhoWidget.dart';
import 'package:projeto_flutter/views/pedido/pedido.dart';
import '../pedido/ListaProduto.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';

class PedidoTesteView extends StatefulWidget {
  BuildContext? context;
  GlobalKey<FormState> formKeyCliente = GlobalKey<FormState>();

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
    if (widget.formKeyCliente.currentState!.validate()) {
      var carrinhoCompra = widget.context!.read<CarrinhoCompra>();
      //Pedido
      PedidoModel pedidoModel = new PedidoModel(
          idCliente: 100,
          idFuncionario: 1,
          data: DateTime.now().toString(),
          total: carrinhoCompra.getTotal());

      PedidoController pedidoController = PedidoController();
      PedidoModel pedido = await pedidoController.crie(pedidoModel);

      ItemPedidoController itemPedidoController = new ItemPedidoController();

      //Monta os items do pedido
      carrinhoCompra.itemCarrinho!.forEach((item) {
        ItemPedidoModel itemPedidoModel = new ItemPedidoModel(
            idPedido: pedido.id,
            idProduto: item.produto!.id,
            quantidade: item.quantidade,
            valorUnitario: item.produto!.valorVenda,
            valorTotal: item.getSubTotal());

        itemPedidoController.crie(itemPedidoModel);
      });

      //Limpa carrinho
      carrinhoCompra.limpar();
      widget.formKeyCliente.currentState!.reset();

      _showDialog(context, pedido);
    }
  }

  void _showDialog(BuildContext context, PedidoModel pedido) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Pedido"),
          actions: <Widget>[
            Column(
              children: [
                TextComponent(label: 'Pedido finalizado com sucesso !'),
                ButtonComponent(
                  label: 'Confimar pedido',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    final carrinhoCompra = context.watch<CarrinhoCompra>();

    var size = MediaQuery.of(context).size;

    return ResponsiveComponent(
      mobile: Scaffold(
        appBar: AppBarComponent(),
        drawer: DrawerComponent(),
        body: Column(
          children: [
            SubMenuComponent(
                titulo: 'Pedido',
                tituloPrimeiraRota: 'Cadastrar',
                primeiraRota: '/pedido_cadastrar',
                tituloSegundaRota: 'Consultar',
                segundaRota: '/pedido_consultar'),
            Container(
                height: size.height * 0.80,
                margin: marginPadrao,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              child: FormCliente(
                            formKeyCliente: widget.formKeyCliente,
                          )),
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
                      height: size.height,
                      child: FormCliente(
                        formKeyCliente: widget.formKeyCliente,
                      ),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextComponent(
                        label: 'por ',
                        cor: colorAzul,
                      ),
                      TextComponent(
                        label: 'R\$ ' +
                            formatoPreco
                                .format(carrinhoCompra.getTotal())
                                .toString(),
                        cor: colorAzul,
                        tamanho: 18,
                      ),
                    ],
                  ))),
        ),
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
