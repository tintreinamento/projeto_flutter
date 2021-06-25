import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/util/ItemCarrinho.dart';

class CarrinhoCompra extends ChangeNotifier {
  ClienteModel? cliente;
  List<ItemCarrinho>? itemCarrinho = [];

  addItemCarrinho(ProdutoModel produto) {
    int index = itemCarrinho!.indexWhere((item) {
      return item.produto!.id == produto.id;
    });

    if (index < 0) {
      ItemCarrinho item = new ItemCarrinho(produto: produto, quantidade: 1);
      itemCarrinho!.add(item);
    } else {
      itemCarrinho![index].quantidade++;
    }
    notifyListeners();
  }

  removeItemCarrinho(ProdutoModel produto) {
    int index = itemCarrinho!.indexWhere((item) {
      return item.produto!.id == produto.id;
    });

    if (index != -1) {
      if (itemCarrinho![index].quantidade > 1) {
        itemCarrinho![index].quantidade--;
      }
      if (itemCarrinho![index].quantidade == 1) {
        itemCarrinho!.removeWhere((item) {
          return item.produto!.id == produto.id;
        });
      }
    }
    notifyListeners();
  }

  getQuantidade(ProdutoModel produto) {
    int index = itemCarrinho!.indexWhere((item) {
      return item.produto!.id == produto.id;
    });
    if (index < 0) {
      return 0;
    } else {
      return itemCarrinho![index].quantidade;
    }
  }

  getTotal() {
    double total = 0;
    for (ItemCarrinho item in itemCarrinho!) {
      total += item.getSubTotal();
    }

    return total;
  }
}
