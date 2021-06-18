class PedidoFornecedorModel {
  var id;
  var idFornecedor;
  var idFuncionario;
  var total;
  var data;

  PedidoFornecedorModel({
    this.id,
    this.idFornecedor,
    this.idFuncionario,
    this.total,
    this.data,
  });

  factory PedidoFornecedorModel.fromJson(Map<String, dynamic> parsedJson) {
    return PedidoFornecedorModel(
        id: parsedJson['id'],
        idFuncionario: parsedJson['id_funcionario'],
        idFornecedor: parsedJson['id_fornecedor'],
        total: parsedJson['valor_total'],
        data: parsedJson['data_entrada']);
  }

  Map<String, dynamic> toJson() => {
        'id_funcionario': idFuncionario,
        'id_fornecedor': idFornecedor,
        'valor_total': total,
        'data_entrada': data
      };
}
