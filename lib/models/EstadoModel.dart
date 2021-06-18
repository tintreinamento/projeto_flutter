class EstadoModel {
  var id;
  var idPais;
  var nome;

  EstadoModel({this.id, this.idPais, this.nome});

  factory EstadoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstadoModel(idPais: parsedJson['id_pais'], nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {'nome': nome, 'id_pais': idPais};
}
