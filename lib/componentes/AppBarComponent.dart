import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/styles.dart';
import 'TextComponent.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
        icon: Icon(Icons.menu),
        color: colorBranco,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      TextComponent(label: 'Sistema de Gestão de Vendas',cor: colorBranco,
      fontSize: 14,
      fontWeight: FontWeight.bold,)
        ],
      )
    );
    
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
