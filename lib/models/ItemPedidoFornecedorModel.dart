class ItemPedidoFornecedorModel {
  var id;
  var idPedido;
  var idProduto;
  var quantidade;
  var valorUnidade;
  var valorTotal;

  ItemPedidoFornecedorModel(
      {this.id,
      this.idPedido,
      this.idProduto,
      this.quantidade,
      this.valorUnidade,
      this.valorTotal});

  factory ItemPedidoFornecedorModel.fromJson(Map<String, dynamic> parsedJson) {
    return ItemPedidoFornecedorModel(
        id: parsedJson['ID_ITEM_PEDIDO_FORNECEDOR'],
        idPedido: parsedJson['ID_PEDIDO'],
        idProduto: parsedJson['ID_PRODUTO'],
        quantidade: parsedJson['QUANTIDADE'],
        valorUnidade: parsedJson['VALOR_UNIDADE'],
        valorTotal: parsedJson['VALOR_TOTAL']);
  }

  Map<String, dynamic> toJson() => {
        'ID_PEDIDO': idPedido,
        'ID_PRODUTO': idProduto,
        'QUANTIDADE': quantidade,
        'VALOR_UNIDADE': valorUnidade,
        'VALOR_TOTAL': valorTotal,
      };
}
