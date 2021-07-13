import 'dart:convert';

import 'package:projeto_flutter/models/PedidoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class PedidoController {
  Future<List<PedidoModel>?> obtenhaTodos() async {
    final resposta = await new Api().obtenha('pedido');

    List<PedidoModel> colecaoDePedidos = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new PedidoModel.fromJson(element);
      colecaoDePedidos.add(pedido);
    });

    return colecaoDePedidos;
  }

  Future<PedidoModel?> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('pedido/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new PedidoModel.fromJson(stringJson);
  }

  Future<PedidoModel> crie(PedidoModel pedido) async {
    final resposta = await new Api().crie('pedido', json.encode(pedido));
    print(resposta);
    var stringJson = json.decode(resposta.body);
    print(stringJson);
    return new PedidoModel.fromJson(stringJson);
  }

  Future<PedidoModel> delete(PedidoModel pedido) async {
    final resposta = await new Api().delete('pedido/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new PedidoModel.fromJson(stringJson);
  }

  Future<PedidoModel> atualize(PedidoModel pedido) async {
    final resposta = await new Api()
        .atualize('pedido/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new PedidoModel.fromJson(stringJson);
  }
}
