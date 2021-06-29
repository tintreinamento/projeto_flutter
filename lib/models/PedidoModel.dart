import 'dart:convert';

import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';

class PedidoModel {
  int? id;
  String? dataPedido;
  String? totalPedido;
  List<ItemPedidoModel>? itemPedido;
  EnderecoModel? endereco;

  PedidoModel({
    this.id,
    this.dataPedido,
    this.totalPedido,
    this.itemPedido,
    this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataPedido': dataPedido,
      'totalPedido': totalPedido,
      'itemPedido': itemPedido?.map((x) => x.toMap()).toList(),
      'endereco': endereco?.toMap(),
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'],
      dataPedido: map['dataPedido'],
      totalPedido: map['totalPedido'],
      itemPedido: List<ItemPedidoModel>.from(
          map['itemPedido']?.map((x) => ItemPedidoModel.fromMap(x))),
      endereco: EnderecoModel.fromMap(map['endereco']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) =>
      PedidoModel.fromMap(json.decode(source));
}
