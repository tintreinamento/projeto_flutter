import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiCorreios {
  static const URL_API = 'https://viacep.com.br/ws/';
  static const URL_FORMAT = '/json/';

  Future<Response> obtenha(String query) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var resposta = await http.get(Uri.parse(URL_API + query + URL_FORMAT),
        headers: headers);

    return resposta;
  }
}
