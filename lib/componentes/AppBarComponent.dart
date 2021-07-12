import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'package:projeto_flutter/models/CarrinhoModel.dart';
import 'TextComponent.dart';
import 'package:provider/provider.dart';
class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String titulo = 'Sistema de Gestão de Vendas';
  final AppBar appBar = new AppBar();

  /// you can add more fields that meet your needs

  AppBarComponent({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height * 0.1,
        padding: paddingPadrao,
        color: colorAzul,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              color: colorBranco,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
       
            Row(children: [
              TextComponent(
              label: 'Sistema de Gestão de Vendas',
              cor: colorBranco,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            //Icone do carrinho de compra com interação
            // SizedBox(
            //   width: 5,
            // ),
            // Stack(
            //   overflow: Overflow.visible,
            //   children: [
            //     Icon(
            //       Icons.shopping_cart_outlined,
            //       color: colorBranco,
            //       size: 28,
            //     ),
            //     Positioned(
            //         right: -2,
            //         bottom: -5,
            //         child: Container(
            //           height: 20,
            //           width: 20,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(50),
            //               color: colorVermelho),
            //           child: Align(
            //             alignment: Alignment.center,
            //             child: Text(
            //               context.watch<CarrinhoModel>().itemPedido.length.toString(),
            //               style: TextStyle(
            //                 fontSize: 9,
            //                   color: colorBranco, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ))
            //   ],
            // )
            ],)
          ],
        ));

    // return PreferredSize(
    //     child: AppBar(
    //       backgroundColor: Color.fromRGBO(0, 94, 181, 1),
    //       actions: [],
    //       flexibleSpace: Container(
    //         height: mediaQuery.size.height * 0.1,
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 height: 73.0,
    //                 padding: EdgeInsets.only(top: 30, right: 6, bottom: 5),
    //                 alignment: Alignment.centerRight,
    //                 child: TextComponent(
    //                   label: titulo,
    //                   fontSize: 14,

    //                   cor: colorBranco,
    //                   fontWeight: FontWeight.bold,
    //                 )
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     preferredSize: Size.fromHeight(73.0));
  }
}
