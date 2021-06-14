class ProdutoModel {
  var id;
  var nome;
  var descricao;
  var valorCompra;
  var valorVenda;
  var imageLinks;

  ProdutoModel(
      {this.id,
      this.nome,
      this.descricao,
      this.valorCompra,
      this.valorVenda,
      this.imageLinks});

  factory ProdutoModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProdutoModel(
        id: parsedJson['id'],
        nome: parsedJson['nome'],
        descricao: parsedJson['descricao'],
        valorCompra: parsedJson['valor_compra'],
        valorVenda: parsedJson['valor_venda'],
        imageLinks: parsedJson['image-links']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
        'valor_compra': valorCompra,
        'valor_venda': valorVenda,
        'image-links': imageLinks,
      };
}
