import 'dart:convert';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/services/Api.dart';

class ClienteController {
  Future<List<ClienteModel?>?> obtenhaTodos() async {
    final resposta = await new Api().obtenha('cliente');
   
    if(resposta.statusCode == 404){
      return null;
    }

    List<ClienteModel> colecaoDeClientes = new List.empty(growable: true);

    List<dynamic> stringJson = json.decode(resposta.body);

    stringJson.forEach((element) {
      var cliente = new ClienteModel.fromJson(element);
      colecaoDeClientes.add(cliente);
    });

    return colecaoDeClientes;
  }

  Future<ClienteModel?> obtenhaPorCpf(String cpf) async {
    final resposta = await new Api().obtenha('cliente/cpf/' + cpf);
  
    if(resposta.statusCode == 404){
      return null;
    }
    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson);
  }

  Future<ClienteModel?> obtenhaPorId(int id) async {
    final resposta = await new Api().obtenha('cliente/' + id.toString());
    if(resposta!.body == null){
      return null;
    }
    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson);
  }

  Future<ClienteModel> crie(ClienteModel cliente) async {
    final resposta = await new Api().crie('cliente', json.encode(cliente));

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson);
  }

  Future<ClienteModel> delete(ClienteModel cliente) async {
    final resposta = await new Api().delete('cliente/' + cliente.id.toString());

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson);
  }

  Future<ClienteModel> atualize(ClienteModel cliente) async {
    final resposta = await new Api()
        .atualize('cliente/' + cliente.id.toString(), json.encode(cliente));

    var stringJson = json.decode(resposta.body);

    return new ClienteModel.fromJson(stringJson);
  }
}
