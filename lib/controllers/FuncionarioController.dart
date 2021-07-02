import 'dart:convert';
import 'package:projeto_flutter/models/FuncionarioModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class FuncionarioController {
  Future<List<FuncionarioModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('funcionario');

    List<FuncionarioModel> colecaoDeFuncionarios =
        new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var funcionario = new FuncionarioModel.fromJson(element);
      colecaoDeFuncionarios.add(funcionario);
    });

    return colecaoDeFuncionarios;
  }

  Future<FuncionarioModel> crie(FuncionarioModel funcionario) async {
    final resposta =
        await new Api().crie('funcionario', json.encode(funcionario));

    var stringJson = json.decode(resposta.body);

    return new FuncionarioModel.fromJson(stringJson);
  }

  Future<FuncionarioModel> delete(FuncionarioModel funcionario) async {
    final resposta =
        await new Api().delete('funcionario/' + funcionario.id.toString());

    var stringJson = json.decode(resposta.body);

    return new FuncionarioModel.fromJson(stringJson);
  }

  Future<FuncionarioModel> atualize(FuncionarioModel funcionario) async {
    final resposta = await new Api().atualize(
        'funcionario/' + funcionario.id.toString(), json.encode(funcionario));

    var stringJson = json.decode(resposta.body);

    return new FuncionarioModel.fromJson(stringJson);
  }
}
