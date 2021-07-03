class EstadoModel {
  var id;
  var idPais;
  var nome;

  EstadoModel({this.id, this.idPais, this.nome});

  factory EstadoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstadoModel(
        id: parsedJson['ID_ESTADO'],
        idPais: parsedJson['ID_PAIS'],
        nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {'NOME': nome, 'ID_PAIS': idPais};
}
