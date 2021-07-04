import 'dart:convert';
import 'package:projeto_flutter/controllers/CategoriaController.dart';
import 'package:projeto_flutter/models/ProdutoModel.dart';
import 'package:projeto_flutter/services/Api.dart';
import 'package:projeto_flutter/views/precificacao/precificacaoView.dart';

class ProdutoController {
  Future<List<ProdutoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('produto');

    List<ProdutoModel> colecaoDeProdutos = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var produto = new ProdutoModel.fromJson(element);
      colecaoDeProdutos.add(produto);
    });

    return colecaoDeProdutos;
  }

  Future<List<ProdutoCategoriaModel>> obtenhaTodosComCategoria() async {
    var colecaoDeProdutos = await obtenhaTodos();
    var categorias = await new CategoriaController().obtenhaTodos();

    List<ProdutoCategoriaModel> colecaoProdutoComCategoria =
        new List.empty(growable: true);

    colecaoDeProdutos.forEach((element) async {
      var produtoCategoria = new ProdutoCategoriaModel();
      produtoCategoria.categoriaModel = categorias
          .firstWhere((categoria) => categoria.id == element.idCategoria);
      produtoCategoria.produto = element;

      colecaoProdutoComCategoria.add(produtoCategoria);
    });

    return colecaoProdutoComCategoria;
  }

  Future<ProdutoModel> obtenhaPorNome(String nome) async {
    final resposta = await new Api().obtenha('produto/nome/' + nome);

    var stringJson = json.decode(resposta.body);

    return new ProdutoModel.fromJson(stringJson);
  }

  Future<ProdutoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('produto/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new ProdutoModel.fromJson(stringJson);
  }

  Future<ProdutoModel> crie(ProdutoModel produto) async {
    final resposta = await new Api().crie('produto', json.encode(produto));

    var stringJson = json.decode(resposta.body);

    return new ProdutoModel.fromJson(stringJson);
  }

  Future<ProdutoModel> delete(ProdutoModel produto) async {
    final resposta = await new Api().delete('produto/' + produto.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ProdutoModel.fromJson(stringJson);
  }

  Future<ProdutoModel> atualize(ProdutoModel produto) async {
    final resposta = await new Api()
        .atualize('produto/' + produto.id.toString(), json.encode(produto));

    var stringJson = json.decode(resposta.body);

    return new ProdutoModel.fromJson(stringJson);
  }
}
