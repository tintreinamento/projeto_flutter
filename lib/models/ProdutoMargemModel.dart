class ProdutoMargemModel {
  var id;
  var idProduto;
  var margem;

  ProdutoMargemModel({this.id, this.idProduto, this.margem});

  factory ProdutoMargemModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProdutoMargemModel(
        id: parsedJson['ID_PRODUTO_MARGEM'],
        idProduto: parsedJson['ID_PRODUTO'],
        margem: parsedJson['MARGEM']);
  }

  Map<String, dynamic> toJson() => {'ID_PRODUTO': idProduto, 'MARGEM': margem};
}
