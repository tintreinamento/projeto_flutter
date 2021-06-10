class ProdutoModels {
  String? nome = "";
  double? preco;
  int? quantidade;

  ProdutoModels(String nome, double preco, int quantidade) {
    this.nome = nome;
    this.preco = preco;
    this.quantidade = quantidade;
  }

  String getNome() {
    return this.nome!;
  }

  double getPreco() {
    return this.preco!;
  }

  int getQuantidade() {
    return this.quantidade!;
  }
}
