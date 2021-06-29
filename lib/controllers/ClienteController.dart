import 'dart:convert';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ClienteController {
  Future<List<ClienteModel>> obtenhaTodos() async {
    final resposta = await new Api().obtenha('clientes');

    List<ClienteModel> colecaoDeClientes = new List.empty(growable: true);

    var stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var cliente = new ClienteModel.fromMap(element);
      colecaoDeClientes.add(cliente);
    });

    return colecaoDeClientes;
  }

  Future<ClienteModel> obtenhaPorCpf(String cpfCnpj) async {
    final resposta = await new Api().obtenha('clientes?cpfCnpj=' + cpfCnpj);

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromMap(stringJson[0]);
  }

  Future<ClienteModel> crie(ClienteModel cliente) async {
    final resposta = await new Api().crie('clientes', cliente.toJson());

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromMap(stringJson);
  }

  // Future<ClienteModel> delete(ClienteModel cliente) async {
  //   final resposta =
  //       await new Api().delete('clientes/' + cliente.id.toString());

  //   var stringJson = json.decode(resposta.body);

  //   return new ClienteModel.fromJson(stringJson);
  // }

  // Future<ClienteModel> atualize(ClienteModel cliente) async {
  //   final resposta = await new Api()
  //       .atualize('clientes/' + cliente.id.toString(), json.encode(cliente));

  //   var stringJson = json.decode(resposta.body);

  //   return new ClienteModel.fromJson(stringJson);
  // }
}
