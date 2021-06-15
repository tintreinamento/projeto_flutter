class ProdutoModel {
  var id;
  var nome;
  var categoria;
  var descricao;
  var valorCompra;
  var valorVenda;
  var imageLinks;

  ProdutoModel(
      {this.id,
      this.nome,
      this.categoria,
      this.descricao,
      this.valorCompra,
      this.valorVenda,
      this.imageLinks});

  factory ProdutoModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProdutoModel(
        id: parsedJson['id'],
        nome: parsedJson['nome'],
        categoria: parsedJson['categoria'],
        descricao: parsedJson['descricao'],
        valorCompra: parsedJson['valor_compra'],
        valorVenda: parsedJson['valor_venda'],
        imageLinks: parsedJson['image-links']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'categoria': categoria,
        'descricao': descricao,
        'valor_compra': valorCompra,
        'valor_venda': valorVenda,
        'image-links': imageLinks,
      };
}
