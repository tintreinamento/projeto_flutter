class CidadeModel {
  var id;
  var idEstado;
  var nome;

  CidadeModel({this.id, this.idEstado, this.nome});

  factory CidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    return CidadeModel(
        id: parsedJson['ID_CIDADE'],
        idEstado: parsedJson['ID_ESTADO'],
        nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {'NOME': nome, 'ID_ESTADO': idEstado};
}
