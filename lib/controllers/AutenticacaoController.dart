import 'dart:convert';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/UsuarioModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class AutenticacaoController {
  Future<AutenticacaoModel> crie(String identificador, String senha) async {
    final resposta = await new Api().crie('auth/local',
        json.encode({"identifier": identificador, "password": senha}));
    print(json.decode(resposta.body));
    var stringJson = json.decode(resposta.body);

    return new AutenticacaoModel.fromMap(stringJson);
  }
}
