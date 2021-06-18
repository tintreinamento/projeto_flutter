import 'dart:convert';
import 'package:projeto_flutter/models/PaisModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class PaisController {

  Future<PaisModel> obtenhaPorId(String id) async {
    final resposta = await new Api().obtenha('pais?id=' + id);

    var stringJson = json.decode(resposta.body);

    return new PaisModel.fromJson(stringJson.single);
  }

  Future<PaisModel> crie(PaisModel pais) async {
    final resposta = await new Api().crie('pais', json.encode(pais));

    var stringJson = json.decode(resposta.body);

    return new PaisModel.fromJson(stringJson);
  }

  Future<PaisModel> delete(PaisModel pais) async {
    final resposta =
        await new Api().delete('pais/' + pais.id.toString());

    var stringJson = json.decode(resposta.body);

    return new PaisModel.fromJson(stringJson);
  }

  Future<PaisModel> atualize(PaisModel pais) async {
    final resposta = await new Api()
        .atualize('pais/' + pais.id.toString(), json.encode(pais));

    var stringJson = json.decode(resposta.body);


    return new PaisModel.fromJson(stringJson);
  }
}
