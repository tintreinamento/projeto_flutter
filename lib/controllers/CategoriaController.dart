import 'dart:convert';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class CategoriaController {
  Future<CategoriaModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('categoria/' + id.toString());

    var stringJson = json.decode(resposta.body);
    return new CategoriaModel.fromJson(stringJson.single);
  }

  Future<CategoriaModel> crie(CategoriaModel cidade) async {
    final resposta = await new Api().crie('categoria', json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }

  Future<CategoriaModel> delete(CategoriaModel cidade) async {
    final resposta =
        await new Api().delete('categoria/' + cidade.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }

  Future<CategoriaModel> atualize(CategoriaModel cidade) async {
    final resposta = await new Api()
        .atualize('categoria/' + cidade.nome.toString(), json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }
}
