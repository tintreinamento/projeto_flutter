import 'package:projeto_flutter/controllers/PedidoController.dart';
import 'package:projeto_flutter/models/PedidoModel.dart';

void main(List<String> args) async {
  PedidoController pedidoController = new PedidoController();

  List<PedidoModel> listaPedidos;
  listaPedidos = await pedidoController.obtenhaTodos();

  print(listaPedidos[1].itemPedido![0].produto!.nome);
}
