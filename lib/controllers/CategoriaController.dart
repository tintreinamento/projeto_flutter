import 'dart:convert';
import 'package:projeto_flutter/models/CategoriaModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class CategoriaController {
  Future<CategoriaModel> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('categorias/' + id.toString());

    var stringJson = json.decode(resposta.body);
    return new CategoriaModel.fromJson(stringJson.single);
  }

  Future<CategoriaModel> crie(CategoriaModel cidade) async {
    final resposta = await new Api().crie('categorias', json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }

  Future<CategoriaModel> delete(CategoriaModel cidade) async {
    final resposta =
        await new Api().delete('categorias/' + cidade.nome.toString());

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }

  Future<CategoriaModel> atualize(CategoriaModel cidade) async {
    final resposta = await new Api()
        .atualize('categorias/' + cidade.nome.toString(), json.encode(cidade));

    var stringJson = json.decode(resposta.body);

    return new CategoriaModel.fromJson(stringJson);
  }
}
