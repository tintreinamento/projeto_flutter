import 'dart:convert';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ProdutoController {
  Future<List<ProdutoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('produtos');

    List<ProdutoModel> colecaoDeProdutos = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var produto = new ProdutoModel.fromMap(element);
      colecaoDeProdutos.add(produto);
    });

    return colecaoDeProdutos;
  }

  // Future<ProdutoModel> obtenhaPorNome(String nome) async {
  //   final resposta = await new Api().obtenha('produtos?nome=' + nome);

  //   var stringJson = json.decode(resposta.body);

  //   return new ProdutoModel.fromJson(stringJson.single);
  // }

  // Future<ProdutoModel> obtenhaPorId(int id) async {
  //   final resposta = await new Api().obtenha('produtos/' + id.toString());

  //   var stringJson = json.decode(resposta.body);

  //   return new ProdutoModel.fromJson(stringJson.single);
  // }

  // Future<ProdutoModel> crie(ProdutoModel produto) async {
  //   final resposta = await new Api().crie('produtos', json.encode(produto));

  //   var stringJson = json.decode(resposta.body);

  //   return new ProdutoModel.fromJson(stringJson);
  // }

  // Future<ProdutoModel> delete(ProdutoModel produto) async {
  //   final resposta =
  //       await new Api().delete('produtos/' + produto.id.toString());

  //   var stringJson = json.decode(resposta.body);

  //   return new ProdutoModel.fromJson(stringJson);
  // }

  // Future<ProdutoModel> atualize(ProdutoModel produto) async {
  //   final resposta = await new Api()
  //       .atualize('produtos/' + produto.id.toString(), json.encode(produto));

  //   var stringJson = json.decode(resposta.body);

  //   return new ProdutoModel.fromJson(stringJson);
  // }
}
