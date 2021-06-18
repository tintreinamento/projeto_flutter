// import 'package:flutter/material.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import '../../componentes/inputdecoration.dart';

// import '../../componentes/textstyle.dart';

// import '../../componentes/boxdecoration.dart';

// import '../pedido/pedido.dart';

// import '../../controllers/ProdutoController.dart';

// import 'package:projeto_flutter/models/ProdutoModel.dart';

// import '../../models/ItemPedidoModel.dart';

// class BuscarProduto extends StatefulWidget {
//   Function carregarListaItemPedido;

//   BuscarProduto({Key? key, required this.carregarListaItemPedido})
//       : super(key: key);

//   @override
//   _BuscarProdutoState createState() => _BuscarProdutoState();
// }

// class _BuscarProdutoState extends State<BuscarProduto> {
//   final parametroNomeProdutoController = TextEditingController();

//   late Future<List<ProdutoModel>> listaProduto;

//   List<ItemPedidoModel> listaItemPedido = [];

//   //Future<List<ProdutoModel>> listaProduto = [];

//   // handleOnChangeBusca() {
//   //   //Ordena
//   //   /*widget.listaProduto.sort((a, b) {
//   //     return b
//   //         .getNome()
//   //         .toLowerCase()
//   //         .compareTo(buscaController.text.toLowerCase());
//   //   });*/

//   //   // widget.listaProduto = widget.listaProduto.where((produto) => produto.nome.startsWith(busca));

//   //   //Atualiza o estado
//   //   setState(() {});
//   // }

//   // handleOnPressedAdicionarProduto(ProdutoModels produtoModel) {
//   //   widget.handleAdicionarProduto(produtoModel);

//   //   setState(() {});
//   // }

//   void carregarProdutos() {
//     ProdutoController produtoController = new ProdutoController();

//     listaProduto = produtoController.obtenhaTodos();

//     // print(listaProduto[1].nome);
//     //print(listaProduto);

//     //print(listaProduto);

//     // for (var produto in listaProduto) {
//     //   print(produto.nome);
//     // }
//   }

//   ordenarProduto(nomeProduto) {
//     setState(() {
//       parametroNomeProdutoController.text = nomeProduto;
//     });
//   }

//   limparCampos() {
//     setState(() {
//       parametroNomeProdutoController.text = '';
//     });
//   }

//   void adicionarItemPedido(ProdutoModel produto) {
//     setState(() {
//       int index = listaItemPedido.indexWhere((itemPedido) {
//         return itemPedido.produto!.id == produto.id;
//       });

//       if (index < 0) {
//         ItemPedidoModel itemPedido = new ItemPedidoModel(
//             produto: produto, quantidade: 1, subtotal: produto.valorVenda);
//         listaItemPedido.add(itemPedido);
//       } else {
//         listaItemPedido[index].quantidade++;
//         listaItemPedido[index].subtotal += produto.valorVenda;
//       }

//       carregarListaItemPedidoPai(listaItemPedido);
//     });
//   }

//   removerItemPedido(ProdutoModel produto) {
//     setState(() {
//       int index = listaItemPedido.indexWhere((itemPedido) {
//         return itemPedido.produto!.id == produto.id;
//       });

//       if (index < 0) {
//         //Não existe o produto
//       } else {
//         listaItemPedido[index].quantidade--;
//         listaItemPedido[index].subtotal -= produto.valorVenda;
//       }

//       carregarListaItemPedidoPai(listaItemPedido);
//     });
//   }

//   carregarListaItemPedidoPai(listaItemPedido) {
//     widget.carregarListaItemPedido(listaItemPedido);
//   }

//   getQuantidade(produto) {
//     int index = listaItemPedido.indexWhere((itemPedido) {
//       return itemPedido.produto!.id == produto.id;
//     });

//     if (index < 0) {
//       return 0;
//     }

//     return listaItemPedido[index].quantidade;
//   }

//   @override
//   void initState() {
//     super.initState();
//     carregarProdutos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: listaProduto,
//         builder:
//             (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
//           if (snapshot.hasData) {
//             // Data fetched successfully, display your data here

//             final listaProdutoOrdenada = snapshot.data!.where((produto) {
//               return produto
//                   .getNome()
//                   .toLowerCase()
//                   .startsWith(parametroNomeProdutoController.text);
//             });

//             final listaProduto = listaProdutoOrdenada.map((produto) {
//               return Column(
//                 children: [
//                   Container(
//                     width: 284,
//                     height: 68,
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 238,
//                           height: 68,
//                           padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
//                           color: Color.fromRGBO(235, 231, 231, 1),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Nome: ',
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   ),
//                                   Text(
//                                     produto.nome,
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Categoria:',
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   ),
//                                   Text(
//                                     '',
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Valor de venda: ',
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   ),
//                                   Text(
//                                     produto.valorVenda.toString(),
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontSize: 14,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 46,
//                           height: 68,
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 46,
//                                 height: 45,
//                                 alignment: Alignment.center,
//                                 child: Text(getQuantidade(produto).toString(),
//                                     style: TextStyle(
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 18,
//                                       color: Color.fromRGBO(0, 0, 0, 1),
//                                     )),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 23,
//                                     height: 23,
//                                     child: ElevatedButton(
//                                         style: ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStateProperty
//                                                     .all<Color>(Color.fromRGBO(
//                                                         8, 201, 62, 1)),
//                                             shape: MaterialStateProperty.all<
//                                                     RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(0),
//                                             ))),
//                                         onPressed: () {
//                                           adicionarItemPedido(produto);
//                                         },
//                                         child: Text(
//                                           '+',
//                                           style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 255, 255, 255, 1),
//                                           ),
//                                         )),
//                                   ),
//                                   Container(
//                                     width: 23,
//                                     height: 23,
//                                     // margin: EdgeInsets.only(top: 18, bottom: 13),
//                                     child: ElevatedButton(
//                                         style: ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStateProperty
//                                                     .all<Color>(Color.fromRGBO(
//                                                         206, 5, 5, 1)),
//                                             shape: MaterialStateProperty.all<
//                                                     RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(0),
//                                             ))),
//                                         onPressed: () {
//                                           removerItemPedido(produto);
//                                         },
//                                         child: Text(
//                                           '-',
//                                           style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 255, 255, 255, 1),
//                                           ),
//                                         )),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }).toList();

//             return Container(
//                 width: 330,
//                 margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
//                 padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
//                 decoration: boxDecorationComponente,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Produto:',
//                             style: textStyleComponente,
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 3),
//                             width: 230,
//                             height: 31,
//                             child: TextField(
//                               onChanged: (nomeProduto) {
//                                 ordenarProduto(nomeProduto);
//                               },
//                               decoration: inputDecorationComponente,
//                             ),
//                           )
//                         ],
//                       ),
//                       ...listaProduto,
//                     ],
//                   ),
//                 ));
//           } else if (snapshot.hasError) {
//             // If something went wrong
//             return Text('Something went wrong...');
//           }

//           // While fetching, show a loading spinner.
//           return CircularProgressIndicator();
//         });

//     //   final teste = listaProduto.map((e) {
//     //     return Text(e.nome);
//     //   }).toList();
//     //   print(listaProduto);
//     //   final auxListaProduto = listaProduto.map((produto) {
//     //     return Column(
//     //       children: [
//     //         Container(
//     //           width: 284,
//     //           height: 68,
//     //           child: Row(
//     //             children: [
//     //               Container(
//     //                 width: 238,
//     //                 height: 68,
//     //                 padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
//     //                 color: Color.fromRGBO(235, 231, 231, 1),
//     //                 child: Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: [
//     //                     Text('Nome: ' + produto.nome),
//     //                     Text('Categoria: '),
//     //                     Text('Valor Venda: '),
//     //                   ],
//     //                 ),
//     //               ),
//     //               Container(
//     //                 width: 46,
//     //                 height: 68,
//     //                 child: Column(
//     //                   children: [
//     //                     Container(
//     //                       width: 46,
//     //                       height: 45,
//     //                       alignment: Alignment.center,
//     //                       child: Text('Qu'),
//     //                     ),
//     //                     Row(
//     //                       children: [
//     //                         Container(
//     //                           width: 23,
//     //                           height: 23,
//     //                           child: ElevatedButton(
//     //                               style: ButtonStyle(
//     //                                   backgroundColor:
//     //                                       MaterialStateProperty.all<Color>(
//     //                                           Color.fromRGBO(8, 201, 62, 1)),
//     //                                   shape: MaterialStateProperty.all<
//     //                                           RoundedRectangleBorder>(
//     //                                       RoundedRectangleBorder(
//     //                                     borderRadius: BorderRadius.circular(0),
//     //                                   ))),
//     //                               onPressed: () {
//     //                                 // produto.adicionaQuantidade(1);
//     //                                 // print(produto.getIdProduto());
//     //                                 // widget.handleAdicionarProduto(produto);
//     //                                 // setState(() {});
//     //                               },
//     //                               child: Text(
//     //                                 '+',
//     //                                 style: TextStyle(
//     //                                   fontFamily: 'Roboto',
//     //                                   fontStyle: FontStyle.normal,
//     //                                   fontWeight: FontWeight.w700,
//     //                                   fontSize: 14,
//     //                                   color: Color.fromRGBO(255, 255, 255, 1),
//     //                                 ),
//     //                               )),
//     //                         ),
//     //                         Container(
//     //                           width: 23,
//     //                           height: 23,
//     //                           // margin: EdgeInsets.only(top: 18, bottom: 13),
//     //                           child: ElevatedButton(
//     //                               style: ButtonStyle(
//     //                                   backgroundColor:
//     //                                       MaterialStateProperty.all<Color>(
//     //                                           Color.fromRGBO(206, 5, 5, 1)),
//     //                                   shape: MaterialStateProperty.all<
//     //                                           RoundedRectangleBorder>(
//     //                                       RoundedRectangleBorder(
//     //                                     borderRadius: BorderRadius.circular(0),
//     //                                   ))),
//     //                               onPressed: () {},
//     //                               child: Text(
//     //                                 '-',
//     //                                 style: TextStyle(
//     //                                   fontFamily: 'Roboto',
//     //                                   fontStyle: FontStyle.normal,
//     //                                   fontWeight: FontWeight.w700,
//     //                                   fontSize: 14,
//     //                                   color: Color.fromRGBO(255, 255, 255, 1),
//     //                                 ),
//     //                               )),
//     //                         ),
//     //                       ],
//     //                     )
//     //                   ],
//     //                 ),
//     //               )
//     //             ],
//     //           ),
//     //         ),
//     //       ],
//     //     );
//     //   }).toList();

//     //   return Container(
//     //       width: 330,
//     //       margin: EdgeInsets.fromLTRB(20, 17, 20, 3),
//     //       padding: EdgeInsets.fromLTRB(15, 25, 10, 13),
//     //       decoration: boxDecorationComponente,
//     //       child: SingleChildScrollView(
//     //         child: Column(
//     //           mainAxisAlignment: MainAxisAlignment.start,
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: [
//     //             Row(
//     //               children: [
//     //                 Text(
//     //                   'Produto:',
//     //                   style: textStyleComponente,
//     //                 ),
//     //                 Container(
//     //                   margin: EdgeInsets.only(left: 3),
//     //                   width: 230,
//     //                   height: 31,
//     //                   child: TextField(
//     //                     decoration: inputDecorationComponente,
//     //                   ),
//     //                 )
//     //               ],
//     //             ),
//     //             ...auxListaProduto,
//     //             ...teste,
//     //           ],
//     //         ),
//     //       ));
//     // }
//   }
// }
