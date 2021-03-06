import 'dart:convert';
import 'package:projeto_flutter/models/EstoqueModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class EstoqueController {
  Future<List<EstoqueModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('estoques');

    List<EstoqueModel> colecaoDeEstoques = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var estoque = new EstoqueModel.fromJson(element);
      colecaoDeEstoques.add(estoque);
    });
    return colecaoDeEstoques;
  }

  Future<EstoqueModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('estoques/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new EstoqueModel.fromJson(stringJson.single);
  }

  Future<EstoqueModel> obtenhaPorNome(String nome) async {
    final resposta = await new Api().obtenha('estoques?nome=' + nome);

    var stringJson = json.decode(resposta.body);

    return new EstoqueModel.fromJson(stringJson.single);
  }

  Future<EstoqueModel> crie(EstoqueModel estoque) async {
    final resposta = await new Api().crie('estoques', json.encode(estoque));

    var stringJson = json.decode(resposta.body);

    return new EstoqueModel.fromJson(stringJson);
  }

  Future<EstoqueModel> delete(EstoqueModel estoque) async {
    final resposta =
        await new Api().delete('estoques/' + estoque.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new EstoqueModel.fromJson(stringJson);
  }

  Future<EstoqueModel> atualize(EstoqueModel estoque) async {
    final resposta = await new Api()
        .atualize('estoques/' + estoque.nome.toString(), json.encode(estoque));

    var stringJson = json.decode(resposta.body);

    return new EstoqueModel.fromJson(stringJson);
  }
}
