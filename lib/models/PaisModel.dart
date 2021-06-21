class PaisModel {
  var id;
  var nome;

  PaisModel({this.id, this.nome});

  factory PaisModel.fromJson(Map<String, dynamic> parsedJson) {
    return PaisModel(id: parsedJson['id'], nome: parsedJson['nome']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
      };
}
