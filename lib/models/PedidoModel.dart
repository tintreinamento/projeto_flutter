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
        total: parsedJson['valor_total'],
        data: parsedJson['data_entrada']);
  }

  Map<String, dynamic> toJson() => {
        'id_funcionario': idFuncionario,
        'id_cliente': idCliente,
        'valor_total': total,
        'data_entrada': data
      };
}
