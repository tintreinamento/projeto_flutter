class EstoqueModel {
  var id;
  var idProduto;
  var quantidade;
  var nome;

  EstoqueModel({
    this.id,
    this.idProduto,
    this.quantidade,
    this.nome,
  });

  factory EstoqueModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstoqueModel(
        id: parsedJson['id'],
        idProduto: parsedJson['id_produto'],
        quantidade: parsedJson['quantidade'],
        nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {
        'id_produto': idProduto,
        'quantidade': quantidade,
        'nome': nome,
      };
}
