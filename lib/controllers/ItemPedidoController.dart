import 'dart:convert';

import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ItemPedidoController {
  Future<List<ItemPedidoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('item-pedido');

    List<ItemPedidoModel> colecaoDeItemPedido = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new ItemPedidoModel.fromJson(element);
      colecaoDeItemPedido.add(pedido);
    });

    return colecaoDeItemPedido;
  }

  Future<ItemPedidoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('item-pedido/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }

  Future<ItemPedidoModel> crie(ItemPedidoModel pedido) async {
    final resposta = await new Api().crie('item-pedido', json.encode(pedido));

    var stringJson = json.decode(resposta.body);
    print(stringJson);
    return new ItemPedidoModel.fromJson(stringJson);
  }

  Future<ItemPedidoModel> delete(ItemPedidoModel pedido) async {
    final resposta =
        await new Api().delete('item-pedido/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }

  Future<ItemPedidoModel> atualize(ItemPedidoModel pedido) async {
    final resposta = await new Api()
        .atualize('item-pedido/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }
}
