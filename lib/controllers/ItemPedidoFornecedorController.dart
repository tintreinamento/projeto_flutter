import 'dart:convert';

import 'package:projeto_flutter/models/ItemPedidoFornecedorModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ItemPedidoFornecedorController {
  Future<List<ItemPedidoFornecedorModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('item-pedido-fornecedor');

    List<ItemPedidoFornecedorModel> colecaoDeItemPedido =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new ItemPedidoFornecedorModel.fromJson(element);
      colecaoDeItemPedido.add(pedido);
    });

    return colecaoDeItemPedido;
  }

  Future<ItemPedidoFornecedorModel> obtenhaPorId(int id) async {
    final resposta =
        await new Api().obtenha('item-pedido-fornecedor/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoFornecedorModel.fromJson(stringJson.single);
  }

  Future<ItemPedidoFornecedorModel> crie(
      ItemPedidoFornecedorModel pedido) async {
    final resposta =
        await new Api().crie('item-pedido-fornecedor', json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoFornecedorModel.fromJson(stringJson);
  }

  Future<ItemPedidoFornecedorModel> delete(
      ItemPedidoFornecedorModel pedido) async {
    final resposta = await new Api()
        .delete('item-pedido-fornecedor/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoFornecedorModel.fromJson(stringJson);
  }

  Future<ItemPedidoFornecedorModel> atualize(
      ItemPedidoFornecedorModel pedido) async {
    final resposta = await new Api().atualize(
        'item-pedido-fornecedor/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new ItemPedidoFornecedorModel.fromJson(stringJson);
  }
}
