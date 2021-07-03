import 'dart:convert';
import 'package:projeto_flutter/models/FornecedorModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class FornecedorController {
  Future<List<FornecedorModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('fornecedor');

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
    final resposta = await new Api().obtenha('fornecedor/nome/' + nome);

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson.single);
  }

  Future<FornecedorModel> crie(FornecedorModel fornecedor) async {
    final resposta =
        await new Api().crie('fornecedor', json.encode(fornecedor));

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }

  Future<FornecedorModel> delete(FornecedorModel fornecedor) async {
    final resposta =
        await new Api().delete('fornecedor/' + fornecedor.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }

  Future<FornecedorModel> atualize(FornecedorModel fornecedor) async {
    final resposta = await new Api().atualize(
        'fornecedor/' + fornecedor.nome.toString(), json.encode(fornecedor));

    var stringJson = json.decode(resposta.body);

    return new FornecedorModel.fromJson(stringJson);
  }
}
