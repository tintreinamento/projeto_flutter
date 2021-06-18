class CidadeModel {
  var id;
  var nome;

  CidadeModel(
      {this.id,
      this.nome});

  factory CidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    return CidadeModel(
        nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
      };
}
