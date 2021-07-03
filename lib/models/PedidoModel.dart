class PedidoModel {
  var id;
  var idCliente;
  var idFuncionario;
  var total;
  var data;

  PedidoModel({
    this.id,
    this.idCliente,
    this.idFuncionario,
    this.total,
    this.data,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> parsedJson) {
    return PedidoModel(
        id: parsedJson['ID_PEDIDO'],
        idFuncionario: parsedJson['ID_FUNCIONARIO'],
        idCliente: parsedJson['ID_CLIENTE'],
        total: parsedJson['TOTAL_PEDIDO'],
        data: parsedJson['DATA_PEDIDO']);
  }

  Map<String, dynamic> toJson() => {
        'ID_FUNCIONARIO': idFuncionario,
        'ID_CLIENTE': idCliente,
        'TOTAL_PEDIDO': total,
        'DATA_PEDIDO': data
      };
}
