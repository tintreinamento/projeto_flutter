class CategoriaModel {
  var id;
  var nome;

  CategoriaModel({this.id, this.nome});

  factory CategoriaModel.fromJson(Map<String, dynamic> parsedJson) {
    return CategoriaModel(
        id: parsedJson['ID_CATEGORIA'], nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {'NOME': nome};
}
