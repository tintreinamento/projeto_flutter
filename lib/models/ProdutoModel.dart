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
        id: parsedJson['id'],
        nome: parsedJson['nome'],
        idCategoria: parsedJson['id_categoria'],
        idFornecedor: parsedJson['id_fornecedor'],
        descricao: parsedJson['descricao'],
        valorCompra: parsedJson['valor_compra'],
        valorVenda: parsedJson['valor_venda']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'id_categoria': idCategoria,
        'id_fornecedor': idFornecedor,
        'descricao': descricao,
        'valor_compra': valorCompra,
        'valor_venda': valorVenda
      };
}
