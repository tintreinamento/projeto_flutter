import 'package:projeto_flutter/controllers/ClienteController.dart';
import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/ClienteModel.dart';
import 'package:projeto_flutter/models/EnderecoModel.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

void main(List<String> args) async {
  // PedidoController pedidoController = new PedidoController();

  // List<PedidoModel> listaPedidos;
  // listaPedidos = await pedidoController.obtenhaTodos();

  // print(listaPedidos[1].itemPedido![0].produto!.nome);

  ClienteController clienteController = new ClienteController();

  ClienteModel clienteModel = new ClienteModel(
      nome: 'Leonardo',
      cpfCnpj: '23565163123',
      endereco: new EnderecoModel(logradouro: 'casa'));

  List<ClienteModel> teste = await clienteController.obtenhaTodos();

  teste.forEach((element) {
    print(element.nome);
  });
}
