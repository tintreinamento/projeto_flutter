class PaisModel {
  var id;
  var nome;

  PaisModel({this.id, this.nome});

  factory PaisModel.fromJson(Map<String, dynamic> parsedJson) {
    return PaisModel(id: parsedJson['ID_PAIS'], nome: parsedJson['NOME']);
  }

  Map<String, dynamic> toJson() => {
        'NOME': nome,
      };
}
