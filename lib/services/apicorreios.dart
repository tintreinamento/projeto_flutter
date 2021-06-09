import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getEndereco(String cep) async {
  final request = Uri.parse('https://viacep.com.br/ws/' + cep + '/json/');
  http.Response response = await http.get(request);

  return jsonDecode(response.body);
}
