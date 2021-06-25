import 'dart:convert';
import 'package:projeto_flutter/models/EnderecoCorreioModel.dart';

import 'package:projeto_flutter/services/apicorreios.dart';

class EnderecoCorreioController {
  Future<EnderecoCorreioModel> obtenhaEnderecoPorCep(String cep) async {
    final resposta = await new ApiCorreios().obtenha(cep);

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new EnderecoCorreioModel.fromJson(stringJson);
  }
}
