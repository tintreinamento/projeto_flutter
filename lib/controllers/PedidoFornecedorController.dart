import 'dart:convert';

import 'package:projeto_flutter/models/PedidoFornecedorModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class PedidoFornecedorController {
  Future<List<PedidoFornecedorModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('pedido-fornecedors');

    List<PedidoFornecedorModel> colecaoDePedidos =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new PedidoFornecedorModel.fromJson(element);
      colecaoDePedidos.add(pedido);
    });

    return colecaoDePedidos;
  }

  Future<PedidoFornecedorModel> obtenhaPorId(int id) async {
    final resposta =
        await new Api().obtenha('pedido-fornecedors/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson.single);
  }

  Future<PedidoFornecedorModel> crie(PedidoFornecedorModel pedido) async {
    final resposta =
        await new Api().crie('pedido-fornecedors', json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }

  Future<PedidoFornecedorModel> delete(PedidoFornecedorModel pedido) async {
    final resposta =
        await new Api().delete('pedido-fornecedors/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }

  Future<PedidoFornecedorModel> atualize(PedidoFornecedorModel pedido) async {
    final resposta = await new Api().atualize(
        'pedido-fornecedors/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }
}
