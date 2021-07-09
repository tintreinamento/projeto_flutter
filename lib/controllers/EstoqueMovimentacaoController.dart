import 'dart:convert';
import 'package:projeto_flutter/controllers/EstoqueController.dart';
import 'package:projeto_flutter/models/EstoqueMovimentacaoModel.dart';
import 'package:projeto_flutter/services/Api.dart';
import 'package:projeto_flutter/views/estoque/EstoqueView.dart';

class EstoqueMovimentacaoController {
  Future<List<EstoqueMovimentacaoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('estoquemv');

    List<EstoqueMovimentacaoModel> colecaoDeEstoques =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var estoque = new EstoqueMovimentacaoModel.fromJson(element);
      colecaoDeEstoques.add(estoque);
    });

    return colecaoDeEstoques;
  }

  Future<EstoqueMovimentacaoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('estoquemv/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new EstoqueMovimentacaoModel.fromJson(stringJson);
  }

  Future<List<EstoqueMovimentacaoModel>> obtenhaPorEstoque(int id) async {
    final resposta =
        await new Api().obtenha('estoquemv/estoque/' + id.toString());

    List<EstoqueMovimentacaoModel> colecaoDeEstoques =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var estoque = new EstoqueMovimentacaoModel.fromJson(element);
      colecaoDeEstoques.add(estoque);
    });

    return colecaoDeEstoques;
  }

  Future<List<EstoqueMovimentacaoComEstoqueModel>> obtenhaPorProduto(
      int id) async {
    final resposta =
        await new Api().obtenha('estoquemv/produto/' + id.toString());

    List<EstoqueMovimentacaoComEstoqueModel> colecaoDeEstoques =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) async {
      var estoque = new EstoqueMovimentacaoModel.fromJson(element);

      var estoqueModel = new EstoqueMovimentacaoComEstoqueModel();
      estoqueModel.estoque =
          await new EstoqueController().obtenhaPorId(estoque.idEstoque);
      estoqueModel.estoqueMovimentacao = estoque;

      colecaoDeEstoques.add(estoqueModel);
    });

    return colecaoDeEstoques;
  }

  Future<EstoqueMovimentacaoModel> crie(
      EstoqueMovimentacaoModel estoque) async {
    final resposta = await new Api().crie('estoquemv', json.encode(estoque));

    var stringJson = json.decode(resposta.body);

    return new EstoqueMovimentacaoModel.fromJson(stringJson);
  }

  Future<EstoqueMovimentacaoModel> delete(
      EstoqueMovimentacaoModel estoque) async {
    final resposta =
        await new Api().delete('estoquemv/' + estoque.id.toString());

    var stringJson = json.decode(resposta.body);

    return new EstoqueMovimentacaoModel.fromJson(stringJson);
  }

  Future<EstoqueMovimentacaoModel> atualize(
      EstoqueMovimentacaoModel estoque) async {
    final resposta = await new Api()
        .atualize('estoquemv/' + estoque.id.toString(), json.encode(estoque));

    var stringJson = json.decode(resposta.body);

    return new EstoqueMovimentacaoModel.fromJson(stringJson);
  }
}
