class EstadoModel {
  var id;
  var nome;

  EstadoModel(
      {this.id,
      this.nome});

  factory EstadoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstadoModel(
        nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
      };
}
