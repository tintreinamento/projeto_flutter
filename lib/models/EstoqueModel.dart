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
        id: parsedJson['ID_ESTOQUE'],
        idProduto: parsedJson['ID_PRODUTO'],
        quantidade: parsedJson['QUANTIDADE'],
        nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {
        'ID_PRODUTO': idProduto,
        'QUANTIDADE': quantidade,
        'NOME': nome,
      };
}
