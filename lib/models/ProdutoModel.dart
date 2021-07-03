class ProdutoModel {
  var id;
  var idCategoria;
  var idFornecedor;
  var nome;
  var descricao;
  var valorCompra;
  var valorVenda;

  ProdutoModel(
      {this.id,
      this.nome,
      this.idCategoria,
      this.idFornecedor,
      this.descricao,
      this.valorCompra,
      this.valorVenda});

  String getNome() {
    return this.nome;
  }

  factory ProdutoModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProdutoModel(
        id: parsedJson['ID_PRODUTO'],
        nome: parsedJson['NOME'],
        idCategoria: parsedJson['ID_CATEGORIA'],
        idFornecedor: parsedJson['ID_FORNECEDOR'],
        descricao: parsedJson['DESCRICAO'],
        valorCompra: parsedJson['VALOR_COMPRA'],
        valorVenda: parsedJson['VALOR_VENDA']);
  }

  Map<String, dynamic> toJson() => {
        'NOME': nome,
        'ID_CATEGORIA': idCategoria,
        'ID_FORNECEDOR': idFornecedor,
        'DESCRICAO': descricao,
        'VALOR_COMPRA': valorCompra,
        'VALOR_VENDA': valorVenda
      };
}
