import '../models/ProdutoModel.dart';

class ItemPedidoModel {
  ProdutoModel? produto;
  var quantidade;
  var subtotal;

  ItemPedidoModel({this.produto, this.quantidade, this.subtotal});
}
