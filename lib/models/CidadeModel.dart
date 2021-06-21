class CidadeModel {
  var id;
  var idEstado;
  var nome;

  CidadeModel({this.id, this.idEstado, this.nome});

  factory CidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    return CidadeModel(
        id: parsedJson['id'],
        idEstado: parsedJson['id_estado'],
        nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {'nome': nome, 'id_estado': idEstado};
}
