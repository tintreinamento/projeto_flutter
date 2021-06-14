import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  Future<Response> obtenha(String query) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var resposta = await http.get(
        Uri.parse('https://viacep.com.br/ws/' + query + '/json/'),
        headers: headers);

    return resposta;
  }
}
