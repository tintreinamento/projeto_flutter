class CategoriaModel {
  var id;
  var nome;

  CategoriaModel({this.id, this.nome});

  factory CategoriaModel.fromJson(Map<String, dynamic> parsedJson) {
    return CategoriaModel(id: parsedJson['id'], nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {'nome': nome};
}
