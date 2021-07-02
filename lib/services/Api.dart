import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:projeto_flutter/services/Auth.dart';

class Api {
  static const URL_API = 'http://localhost:1337/';

  Future<Response> obtenha(String query) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          Auth.isAuthenticated() ? 'Bearer ${Auth.getToken()}' : '',
    };

    var resposta = await http.get(Uri.parse(URL_API + query), headers: headers);

    return resposta;
  }

  Future<Response> crie(String query, Object body) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          Auth.isAuthenticated() ? 'Bearer ${Auth.getToken()}' : '',
    };
    var resposta = await http.post(Uri.parse(URL_API + query),
        headers: headers, body: body);

    return resposta;
  }

  Future<Response> delete(String query) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var resposta = await http.delete(
      Uri.parse(URL_API + query),
      headers: headers,
    );

    return resposta;
  }

  Future<Response> atualize(String query, Object body) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var resposta = await http.put(Uri.parse(URL_API + query),
        headers: headers, body: body);

    return resposta;
  }
}
