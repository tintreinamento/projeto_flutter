import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/views/pedido/consulta/PedidoConsultaView.dart';

class PedidoModel extends ChangeNotifier {
  int? id;
  String? dataPedido;
  double? totalPedido = 0;
  ClienteModel? cliente = new ClienteModel();
  List<ItemPedidoModel>? itemPedido = [];
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

  void setCliente(ClienteModel cliente) {
    this.cliente = cliente;
    notifyListeners();
  }

  void setClienteEndereco(EnderecoModel endereco) {
    this.cliente!.endereco = endereco;
    notifyListeners();
  }

  void setItemPedido(ProdutoModel produto) {
    print(itemPedido);

    ItemPedidoModel itemPedidoModel =
        new ItemPedidoModel(produto: produto, quantidade: 1);
    this.itemPedido!.add(itemPedidoModel);

    notifyListeners();
  }

  double getTotal() {
    this.totalPedido = 0;
    print(this.totalPedido);
    if (this.itemPedido != null) {
      this.itemPedido!.forEach((element) {
        this.totalPedido = this.totalPedido! + element.getSubtotal();
      });
    }

    return this.totalPedido!;
  }
}
