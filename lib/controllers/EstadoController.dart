import 'dart:convert';
import 'package:projeto_flutter/models/EstadoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class EstadoController {
  Future<List<EstadoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('estados');

    List<EstadoModel> colecaoDeItemPedido = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var pedido = new EstadoModel.fromJson(element);
      colecaoDeItemPedido.add(pedido);
    });

    return colecaoDeItemPedido;
  }

  Future<EstadoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('estados/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new EstadoModel.fromJson(stringJson.single);
  }

  Future<EstadoModel> crie(EstadoModel estado) async {
    final resposta = await new Api().crie('estados', json.encode(estado));

    var stringJson = json.decode(resposta.body);

    return new EstadoModel.fromJson(stringJson);
  }

  Future<EstadoModel> delete(EstadoModel estado) async {
    final resposta =
        await new Api().delete('estados/' + estado.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new EstadoModel.fromJson(stringJson);
  }

  Future<EstadoModel> atualize(EstadoModel estado) async {
    final resposta = await new Api()
        .atualize('estados/' + estado.nome.toString(), json.encode(estado));

    var stringJson = json.decode(resposta.body);

    return new EstadoModel.fromJson(stringJson);
  }
}
