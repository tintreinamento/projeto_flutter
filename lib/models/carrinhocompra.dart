import '../models/produto.dart';

class CarrinhoCompraModels {
  double? total;
  List<ProdutoModels>? listaProduto;

  CarrinhoCompraModels(double total, List<ProdutoModels> listaProduto) {
    this.total = total;
    this.listaProduto = listaProduto;
  }

  get produto => null;

  void addProduto(ProdutoModels produto) {
    listaProduto!.add(produto);
  }

  double getTotal() {
    for (ProdutoModels produto in this.listaProduto!) {
      this.total = this.total! + produto.getPreco();
    }

    return this.total!;
  }
}
