class EstoqueModel {
  var id;
  var quantidade;
  var nome;


  EstoqueModel(
      {this.id,
      this.quantidade,
      this.nome,
      });

  factory EstoqueModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstoqueModel(
        quantidade: parsedJson['quantidade'],
        nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {
        'quantidade': quantidade,
        'nome': nome,
      };
}
