class ItemPedidoModel {
  var id;
  var quantidade;
  var valorUnidade;
  var valorTotal;

  ItemPedidoModel(
      {this.id, this.quantidade, this.valorUnidade, this.valorTotal});

  factory ItemPedidoModel.fromJson(Map<String, dynamic> parsedJson) {
    return ItemPedidoModel(
        id: parsedJson['id'],
        quantidade: parsedJson['quantidade'],
        valorUnidade: parsedJson['valor_unidade'],
        valorTotal: parsedJson['valor_total']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantidade': quantidade,
        'valor_unidade': valorUnidade,
        'valor_total': valorTotal,
      };
}
