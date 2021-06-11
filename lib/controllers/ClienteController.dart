import 'dart:convert';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ClienteController {
  Future<List<ClienteModel>> obtenhaClientes() async {
    final resposta = await new Api().obtenha('clientes');

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao obter os dados na api");
    }

    List<ClienteModel> colecaoDeClientes = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var cliente = new ClienteModel.fromJson(element);
      colecaoDeClientes.add(cliente);
    });

    return colecaoDeClientes;
  }

  Future<ClienteModel> obtenhaClientePorCpf(String cpf) async {
    final resposta = await new Api().obtenha('clientes?cpf=' + cpf);

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson.single);
  }

  Future<ClienteModel> crieCliente(ClienteModel cliente) async {
    print(json.encode(cliente));
    final resposta = await new Api().crie('clientes', json.encode(cliente));

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson.single);
  }
}
