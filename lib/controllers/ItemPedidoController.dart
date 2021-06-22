import 'dart:convert';

import 'package:projeto_flutter/models/ItemPedidoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ItemPedidoController {
  Future<List<ItemPedidoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('item-pedidos');

    List<ItemPedidoModel> colecaoDeItemPedido = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new ItemPedidoModel.fromJson(element);
      colecaoDeItemPedido.add(pedido);
    });

    return colecaoDeItemPedido;
  }

  Future<ItemPedidoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('item-pedidos/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson.single);
  }

  Future<List<ItemPedidoModel>> obtenhaTodosItensPedidosPorIdPedido(
      int id) async {
    final resposta =
        await new Api().obtenha('item-pedidos?id_pedido=' + id.toString());

    List<ItemPedidoModel> colecaoDeItemPedido = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new ItemPedidoModel.fromJson(element);
      colecaoDeItemPedido.add(pedido);
    });

    return colecaoDeItemPedido;
  }

  Future<ItemPedidoModel> crie(ItemPedidoModel pedido) async {
    final resposta = await new Api().crie('item-pedidos', json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }

  Future<ItemPedidoModel> delete(ItemPedidoModel pedido) async {
    final resposta =
        await new Api().delete('item-pedidos/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }

  Future<ItemPedidoModel> atualize(ItemPedidoModel pedido) async {
    final resposta = await new Api()
        .atualize('item-pedidos/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoModel.fromJson(stringJson);
  }
}
