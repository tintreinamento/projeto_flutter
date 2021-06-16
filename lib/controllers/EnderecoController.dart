import 'dart:convert';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/services/apicorreios.dart';

class EnderecoController {
  Future<EnderecoModel> obtenhaEnderecoPorCep(String cep) async {
    final resposta = await new Api().obtenha(cep);

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new EnderecoModel.fromJson(stringJson);
  }
}
