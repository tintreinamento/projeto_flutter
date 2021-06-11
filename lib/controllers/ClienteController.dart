import 'dart:collection';
import 'dart:convert';
import 'package:projeto_flutter/models/Cliente.dart';
import 'package:projeto_flutter/services/Api.dart';

class ClienteController {
  Future<List<Cliente>> obtenhaClientes() async {
    final resposta = await new Api().obtenha('clientes');

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao obter os dados na api");
    }

    List<Cliente> colecaoDeClientes = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var cliente = new Cliente.fromJson(element);
      colecaoDeClientes.add(cliente);
    });

    return colecaoDeClientes;
  }

  Future<Cliente> obtenhaClienteCpf(String cpf) async {
    final resposta = await new Api().obtenha('clientes?cpf=' + cpf);

    if (resposta.statusCode != 200) {
      throw new Exception("Falha ao comunicar com a api");
    }

    var stringJson = json.decode(resposta.body);

    return new Cliente.fromJson(stringJson.single);
  }
}