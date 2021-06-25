import 'package:projeto_flutter/views/pedido/pedido.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class ItemCarrinho {
  ProdutoModel? produto;
  int quantidade = 0;

  ItemCarrinho({this.produto, required this.quantidade});

  getSubTotal() {
    return produto!.valorVenda * quantidade;
  }
}
