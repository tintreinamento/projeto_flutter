import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';

class PedidoModel extends ChangeNotifier {
  int? id;
  String? dataPedido;
  double? totalPedido = 0;
  ClienteModel? cliente = new ClienteModel();
  List<ItemPedidoModel>? itemPedido = [];
  FuncionarioModel? funcionario = new FuncionarioModel();

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

  void setCliente(ClienteModel cliente) {
    this.cliente = cliente;
    notifyListeners();
  }

  void setClienteEndereco(EnderecoModel endereco) {
    this.cliente!.endereco = endereco;
    notifyListeners();
  }

  void setItemPedido(ProdutoModel produto) {
    print('tes');
    int index = itemPedido!.indexWhere((item) {
      return item.produto!.id == produto.id;
    });

    if (index < 0) {
      ItemPedidoModel item =
          new ItemPedidoModel(produto: produto, quantidade: 1);
      this.itemPedido!.add(item);
    } else {
      itemPedido![index].quantidade = itemPedido![index].quantidade! + 1;
    }
    notifyListeners();
  }

  // double getTotal() {
  //   if (this.itemPedido != null) {
  //     this.itemPedido!.forEach((item) {
  //       this.totalPedido = this.totalPedido! + item.getSubtotal();
  //     });
  //   }

  //   print('t');
  //   return this.totalPedido!;
  // }
}
