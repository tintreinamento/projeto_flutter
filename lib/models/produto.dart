class ProdutoModels {
  int idProduto = 0;
  String? nome = "";
  double? preco;
  int quantidade = 0;

  ProdutoModels(int idProduto, String nome, double preco, int quantidade) {
    this.idProduto = idProduto;
    this.nome = nome;
    this.preco = preco;
    this.quantidade = quantidade;
  }

  int getIdProduto() {
    return this.idProduto;
  }

  String getNome() {
    return this.nome!;
  }

  double getPreco() {
    return this.preco!;
  }

  void adicionaQuantidade(int quantidade) {
    this.quantidade += quantidade;
  }

  int getQuantidade() {
    return this.quantidade;
  }
}
