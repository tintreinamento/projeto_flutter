import 'dart:convert';

import 'package:projeto_flutter/models/PedidoFornecedorModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class PedidoFornecedorController {
  Future<List<PedidoFornecedorModel>?> obtenhaTodos() async {
    final resposta = await new Api().obtenha('pedido-fornecedor');
if(resposta!.body == null){
      return null;
    }
    List<PedidoFornecedorModel> colecaoDePedidos =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new PedidoFornecedorModel.fromJson(element);
      colecaoDePedidos.add(pedido);
    });

    return colecaoDePedidos;
  }

  Future<PedidoFornecedorModel?> obtenhaPorId(int id) async {
    final resposta =
        await new Api().obtenha('pedido-fornecedor/' + id.toString());
if(resposta!.body == null){
      return null;
    }
    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }

  Future<PedidoFornecedorModel> crie(PedidoFornecedorModel pedido) async {
    final resposta =
        await new Api().crie('pedido-fornecedor', json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }

  Future<PedidoFornecedorModel> delete(PedidoFornecedorModel pedido) async {
    final resposta =
        await new Api().delete('pedido-fornecedor/' + pedido.id.toString());

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }

  Future<PedidoFornecedorModel> atualize(PedidoFornecedorModel pedido) async {
    final resposta = await new Api().atualize(
        'pedido-fornecedor/' + pedido.id.toString(), json.encode(pedido));

    var stringJson = json.decode(resposta.body);

    return new PedidoFornecedorModel.fromJson(stringJson);
  }
}
