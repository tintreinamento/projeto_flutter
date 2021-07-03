// import 'package:flutter/cupertino.dart';
// import 'package:projeto_flutter/models/ClienteModel.dart';
// import 'package:projeto_flutter/models/FuncionarioModel.dart';
// import 'package:projeto_flutter/models/ItemPedidoModel.dart';
// import 'package:projeto_flutter/models/ProdutoModel.dart';

// class CarrinhoModel extends ChangeNotifier {
//   String dataPedido = DateTime.now().toString();
//   double totalPedido = 0;
//   FuncionarioModel? funcionario;
//   ClienteModel cliente = new ClienteModel();
//   List<ItemPedidoModel> itemPedido = [];

//   getQuantidade(ProdutoModel produto) {
//     int index = itemPedido.indexWhere((item) {
//       return item.produto!.id == produto.id;
//     });
//     if (index < 0) {
//       return 0;
//     } else {
//       return itemPedido[index].quantidade;
//     }
//   }

//   void addItemCarrinho(ProdutoModel produto) {
//     int index = itemPedido.indexWhere((item) {
//       return item.produto!.id == produto.id;
//     });

//     if (index < 0) {
//       ItemPedidoModel item =
//           new ItemPedidoModel(produto: produto, quantidade: 1);
//       itemPedido.add(item);
//     } else {
//       itemPedido[index].quantidade = itemPedido[index].quantidade! + 1;
//     }

//     print(itemPedido);
//     notifyListeners();
//   }

//   void removeItemCarrinho(ProdutoModel produto) {
//     if (itemPedido.length >= 0) {
//       int index = itemPedido.indexWhere((item) {
//         return item.produto!.id == produto.id;
//       });

//       if (index != -1) {
//         if (itemPedido[index].quantidade == 1) {
//           itemPedido.removeWhere((item) {
//             return item.produto!.id == produto.id;
//           });
//         } else {
//           if (itemPedido[index].quantidade! > 1) {
//             itemPedido[index].quantidade = itemPedido[index].quantidade! - 1;
//           }
//         }
//       }
//       notifyListeners();
//     }
//   }

//   double getTotal() {
//     totalPedido = 0;
//     itemPedido.forEach((item) {
//       //totalPedido += item.getSubtotal();
//     });

//     return totalPedido;
//   }
// }
