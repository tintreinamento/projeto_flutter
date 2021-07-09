class EstoqueMovimentacaoModel {
  var id;
  var idEstoque;
  var idProduto;
  var quantidade;

  EstoqueMovimentacaoModel(
      {this.id, this.idEstoque, this.idProduto, this.quantidade});

  factory EstoqueMovimentacaoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstoqueMovimentacaoModel(
        id: parsedJson['ID_MOVIMENTACAO'],
        idEstoque: parsedJson['ID_ESTOQUE'],
        idProduto: parsedJson['ID_PRODUTO'],
        quantidade: parsedJson['QUANTIDADE']);
  }

  Map<String, dynamic> toJson() => {
        'ID_ESTOQUE': idEstoque,
        'ID_PRODUTO': idProduto,
        'QUANTIDADE': quantidade
      };
}
