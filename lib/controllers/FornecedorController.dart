import 'dart:convert';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class FornecedorController {
  Future<List<FornecedorModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('fornecedors');

    List<FornecedorModel> colecaoDeFornecedores =
        new List.empty(growable: true);
    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var fernecedor = new FornecedorModel.fromJson(element);
      colecaoDeFornecedores.add(fernecedor);
    });
    return colecaoDeFornecedores;
  }

  Future<FornecedorModel> obtenhaPorNome(String nome) async {
    final resposta = await new Api().obtenha('fornecedors?nome=' + nome);

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson.single);
  }

  Future<FornecedorModel> crie(FornecedorModel fornecedor) async {
    final resposta =
        await new Api().crie('fornecedors', json.encode(fornecedor));

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }

  Future<FornecedorModel> delete(FornecedorModel fornecedor) async {
    final resposta =
        await new Api().delete('fornecedors/' + fornecedor.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }

  Future<FornecedorModel> atualize(FornecedorModel fornecedor) async {
    final resposta = await new Api().atualize(
        'fornecedors/' + fornecedor.nome.toString(), json.encode(fornecedor));

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }
}
