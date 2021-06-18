class ProdutoMargemModel {
  var id;
  var idProduto;
  var margem;

  ProdutoMargemModel({this.id, this.idProduto, this.margem});

  factory ProdutoMargemModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProdutoMargemModel(
        id: parsedJson['id'],
        idProduto: parsedJson['id_produto'],
        margem: parsedJson['margem']);
  }

  Map<String, dynamic> toJson() => {'id_produto': idProduto, 'margem': margem};
}
