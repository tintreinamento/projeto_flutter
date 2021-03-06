import 'dart:convert';
import 'package:projeto_flutter/models/ProdutoMargemModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ProdutoMargemController {
  Future<List<ProdutoMargemModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('margems');

    List<ProdutoMargemModel> colecaoDeProdutos = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var produto = new ProdutoMargemModel.fromJson(element);
      colecaoDeProdutos.add(produto);
    });

    return colecaoDeProdutos;
  }

  Future<ProdutoMargemModel> obtenhaPorNome(String nome) async {
    final resposta = await new Api().obtenha('margems?nome=' + nome);

    var stringJson = json.decode(resposta.body);

    return new ProdutoMargemModel.fromJson(stringJson.single);
  }

  Future<ProdutoMargemModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('margems/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new ProdutoMargemModel.fromJson(stringJson.single);
  }

  Future<ProdutoMargemModel> crie(ProdutoMargemModel produto) async {
    final resposta = await new Api().crie('margems', json.encode(produto));

    var stringJson = json.decode(resposta.body);

    return new ProdutoMargemModel.fromJson(stringJson);
  }

  Future<ProdutoMargemModel> delete(ProdutoMargemModel produto) async {
    final resposta = await new Api().delete('margems/' + produto.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ProdutoMargemModel.fromJson(stringJson);
  }

  Future<ProdutoMargemModel> atualize(ProdutoMargemModel produto) async {
    final resposta = await new Api()
        .atualize('margems/' + produto.id.toString(), json.encode(produto));

    var stringJson = json.decode(resposta.body);

    return new ProdutoMargemModel.fromJson(stringJson);
  }
}
