import 'dart:convert';

import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';

class PedidoModel {
  int? id;
  String? dataPedido;
  String? totalPedido;
  ClienteModel? cliente;
  List<ItemPedidoModel>? itemPedido;
  FuncionarioModel? funcionario;

  PedidoModel({
    this.id,
    this.dataPedido,
    this.totalPedido,
    this.cliente,
    this.itemPedido,
    this.funcionario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataPedido': dataPedido,
      'totalPedido': totalPedido,
      'cliente': cliente?.toMap(),
      'itemPedido': itemPedido?.map((x) => x.toMap()).toList(),
      'funcionario': funcionario?.toMap(),
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'],
      dataPedido: map['dataPedido'],
      totalPedido: map['totalPedido'],
      cliente: ClienteModel.fromMap(map['cliente']),
      itemPedido: List<ItemPedidoModel>.from(
          map['itemPedido']?.map((x) => ItemPedidoModel.fromMap(x))),
      funcionario: FuncionarioModel.fromMap(map['funcionario']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(String source) =>
      PedidoModel.fromMap(json.decode(source));
}
