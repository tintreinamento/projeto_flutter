import 'dart:convert';
import 'package:projeto_flutter/models/CidadeModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class CidadeController {
  Future<List<CidadeModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('cidades');

    List<CidadeModel> colecaoDeClientes = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var cliente = new CidadeModel.fromJson(element);
      colecaoDeClientes.add(cliente);
    });

    return colecaoDeClientes;
  }

  Future<CidadeModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('cidades/' + id.toString());

    var stringJson = json.decode(resposta.body);
    return new CidadeModel.fromJson(stringJson.single);
  }

  Future<CidadeModel> crie(CidadeModel cidade) async {
    final resposta = await new Api().crie('cidades', json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CidadeModel.fromJson(stringJson);
  }

  Future<CidadeModel> delete(CidadeModel cidade) async {
    final resposta =
        await new Api().delete('cidades/' + cidade.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new CidadeModel.fromJson(stringJson);
  }

  Future<CidadeModel> atualize(CidadeModel cidade) async {
    final resposta = await new Api()
        .atualize('cidades/' + cidade.nome.toString(), json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CidadeModel.fromJson(stringJson);
  }
}
