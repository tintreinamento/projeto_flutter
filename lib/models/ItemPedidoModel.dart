class ItemPedidoModel {
  var id;
  var idPedido;
  var idProduto;
  var quantidade;
  var valorUnitario;
  var valorTotal;

  ItemPedidoModel(
      {this.id,
      this.idPedido,
      this.idProduto,
      this.quantidade,
      this.valorUnitario,
      this.valorTotal});

  factory ItemPedidoModel.fromJson(Map<String, dynamic> parsedJson) {
    return ItemPedidoModel(
        id: parsedJson['ID_ITEM_PEDIDO'],
        idPedido: parsedJson['ID_PEDIDO'],
        idProduto: parsedJson['ID_PRODUTO'],
        quantidade: parsedJson['QUANTIDADE'],
        valorUnitario: parsedJson['VALOR_UNITARIO'],
        valorTotal: parsedJson['VALOR_TOTAL']);
  }

  Map<String, dynamic> toJson() => {
        'ID_PEDIDO': idPedido,
        'ID_PRODUTO': idProduto,
        'QUANTIDADE': quantidade,
        'VALOR_UNITARIO': valorUnitario,
        'VALOR_TOTAL': valorTotal,
      };
}
