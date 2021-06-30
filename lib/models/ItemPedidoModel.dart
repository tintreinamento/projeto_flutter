import 'dart:convert';

import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class ItemPedidoModel {
  int? quantidade = 0;
  ProdutoModel? produto;

  ItemPedidoModel({
    this.quantidade,
    this.produto,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantidade': quantidade,
      'produto': produto?.toMap(),
    };
  }

  factory ItemPedidoModel.fromMap(Map<String, dynamic> map) {
    return ItemPedidoModel(
      quantidade: map['quantidade'],
      produto: ProdutoModel.fromMap(map['produto']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPedidoModel.fromJson(String source) =>
      ItemPedidoModel.fromMap(json.decode(source));

  double getSubtotal() {
    return (this.quantidade! * this.produto!.precoCompra!);
  }
}
