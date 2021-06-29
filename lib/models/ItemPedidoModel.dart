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
        id: parsedJson['id'],
        idPedido: parsedJson['id_pedido'],
        idProduto: parsedJson['id_produto'],
        quantidade: parsedJson['quantidade'],
        valorUnitario: parsedJson['valor_unitario'],
        valorTotal: parsedJson['valor_total']);
  }

  Map<String, dynamic> toJson() => {
        'id_pedido': idPedido,
        'id_produto': idProduto,
        'quantidade': quantidade,
        'valor_unitario': valorUnitario,
        'valor_total': valorTotal,
      };
}
