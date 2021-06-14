class PedidoModel {
  var id;
  var total;
  var data;

  PedidoModel({
    this.id,
    this.total,
    this.data,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> parsedJson) {
    return PedidoModel(
        id: parsedJson['id'],
        total: parsedJson['total'],
        data: parsedJson['data']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'total': total, 'data': data};
}
