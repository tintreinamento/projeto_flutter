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
        id: parsedJson['id'],
        idFuncionario: parsedJson['id_funcionario'],
        idCliente: parsedJson['id_cliente'],
        total: parsedJson['total'],
        data: parsedJson['data']);
  }

  Map<String, dynamic> toJson() => {
        'id_funcionario': idFuncionario,
        'id_cliente': idCliente,
        'total': total,
        'data': data
      };
}
