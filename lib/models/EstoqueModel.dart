class EstoqueModel {
  var id;
  var nome;

  EstoqueModel({
    this.id,
    this.nome,
  });

  factory EstoqueModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstoqueModel(id: parsedJson['ID_ESTOQUE'], nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {
        'NOME': nome,
      };
}
