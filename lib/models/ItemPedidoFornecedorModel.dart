class ItemPedidoFornecedorModel {
  var id;
  var idPedido;
  var idProduto;
  var quantidade;
  var valorUnitario;
  var valorTotal;

  ItemPedidoFornecedorModel(
      {this.id,
      this.idPedido,
      this.idProduto,
      this.quantidade,
      this.valorUnitario,
      this.valorTotal});

  factory ItemPedidoFornecedorModel.fromJson(Map<String, dynamic> parsedJson) {
    return ItemPedidoFornecedorModel(
        id: parsedJson['id'],
        idPedido: parsedJson['id_pedido'],
        idProduto: parsedJson['id_produto'],
        quantidade: parsedJson['quantidade'],
        valorUnitario: parsedJson['valor_unidade'],
        valorTotal: parsedJson['valor_total']);
  }

  Map<String, dynamic> toJson() => {
        'id_pedido': idPedido,
        'id_produto': idProduto,
        'quantidade': quantidade,
        'valor_unidade': valorUnitario,
        'valor_total': valorTotal,
      };
}
