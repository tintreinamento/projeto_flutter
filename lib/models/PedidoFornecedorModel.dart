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
        id: parsedJson['ID_PEDIDO_FORNECEDOR'],
        idFuncionario: parsedJson['ID_FUNCIONARIO'],
        idFornecedor: parsedJson['ID_FORNECEDOR'],
        total: parsedJson['VALOR_TOTAL'],
        data: parsedJson['DATA_ENTRADA']);
  }

  Map<String, dynamic> toJson() => {
        'ID_FUNCIONARIO': idFuncionario,
        'ID_FORNECEDOR': idFornecedor,
        'VALOR_TOTAL': total,
        'DATA_ENTRADA': data
      };
}
