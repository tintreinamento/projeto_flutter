import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_flutter/models/EnderecoCorreiosModel.dart';

class ApiCorreios {
  Future<EnderecoCorreiosModel> obtenhaEndereco(String query) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var resposta = await http.get(
        Uri.parse('https://viacep.com.br/ws/' + query + '/json/'),
        headers: headers);

    return EnderecoCorreiosModel.fromJson(json.decode(resposta.body));
  }
}
