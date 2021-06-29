import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/models/UsuarioModel.dart';
import 'dart:convert';
import 'package:projeto_flutter/services/Api.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';

class AutenticacaoController {
  Future<AutenticacaoModel> crie(AutenticacaoModel autenticacao) async {
    final resposta = await new Api().crie('auth/local', autenticacao.toJson());

    print(resposta.body);

    return new AutenticacaoModel.fromJson(resposta.body);
  }
}
