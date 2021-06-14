import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  Future<Response> obtenha(String query) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var resposta = await http.get(Uri.parse('http://10.66.8.160:1337/' + query),
        headers: headers);

    return resposta;
  }

  Future<Response> crie(String query, Object body) async {
    var resposta = await http
        .post(Uri.parse('http://10.66.8.160:1337/' + query), body: body);

    return resposta;
  }
}
