import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:projeto_flutter/models/ItemPedidoFornecedorModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/models/FornecedorModel.dart';

class CarrinhoCompraModel extends ChangeNotifier {
  String dataPedido = UtilData.obterDataDDMMAAAA(DateTime.now());
  double totalPedido = 0;
  FornecedorModel fornecedor = new FornecedorModel();
  List<ItemPedidoFornecedorModel> itemPedido = [];

  getQuantidade(idProduto) {
    int index = itemPedido.indexWhere((item) {
      return item.idProduto == idProduto;
    });
    if (index < 0) {
      return 0;
    } else {
      return itemPedido[index].quantidade;
    }
  }

  void addItemCarrinho(ProdutoModel produto) {
    int index = itemPedido.indexWhere((item) {
      return item.idProduto == produto.id;
    });

    if (index < 0) {
      var item = new ItemPedidoFornecedorModel(
          idProduto: produto.id,
          quantidade: 1,
          valorUnidade: produto.valorVenda);
      item.valorTotal = produto.valorVenda * item.quantidade;
      itemPedido.add(item);
    } else {
      itemPedido[index].quantidade = itemPedido[index].quantidade! + 1;
    }

    print(itemPedido);
    notifyListeners();
  }

  void removeItemCarrinho(ProdutoModel produto) {
    if (itemPedido.length >= 0) {
      int index = itemPedido.indexWhere((item) {
        return item.idProduto == produto.id;
      });

      if (index != -1) {
        if (itemPedido[index].quantidade == 1) {
          itemPedido.removeWhere((item) {
            return item.idProduto == produto.id;
          });
        } else {
          if (itemPedido[index].quantidade! > 1) {
            itemPedido[index].quantidade = itemPedido[index].quantidade! - 1;
          }
        }
      }
      notifyListeners();
    }
  }

  double getTotal() {
    totalPedido = 0;
    itemPedido.forEach((item) {
      totalPedido += (item.valorUnidade * item.quantidade);
    });

    return totalPedido;
  }

  void limparCarrinho() {
    dataPedido = UtilData.obterDataDDMMAAAA(DateTime.now());
    totalPedido = 0;
    fornecedor = new FornecedorModel();
    itemPedido = [];
  }
}
