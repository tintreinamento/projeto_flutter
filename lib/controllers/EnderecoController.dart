import 'dart:convert';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class EnderecoController {
  Future<EnderecoModel> obtenhaEnderecoPorCep(String cep) async {
    final resposta = await new Api().obtenha(cep);

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson);
  }

  Future<List<EnderecoModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('endereco');

    List<EnderecoModel> colecaoDeEnderecos = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var endereco = new EnderecoModel.fromJson(element);
      colecaoDeEnderecos.add(endereco);
    });

    return colecaoDeEnderecos;
  }

  Future<EnderecoModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('endereco/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson.single);
  }

  Future<EnderecoModel> obtenhaPorIdFornecedor(int id) async {
    final resposta =
        await new Api().obtenha('endereco/fornecedor/' + id.toString());

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson.single);
  }

  Future<EnderecoModel> crie(EnderecoModel endereco) async {
    final resposta = await new Api().crie('endereco', json.encode(endereco));

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson);
  }

  Future<EnderecoModel> delete(EnderecoModel endereco) async {
    final resposta =
        await new Api().delete('endereco/' + endereco.id.toString());

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson);
  }

  Future<EnderecoModel> atualize(EnderecoModel endereco) async {
    final resposta = await new Api()
        .atualize('endereco/' + endereco.id.toString(), json.encode(endereco));

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson);
  }
}
