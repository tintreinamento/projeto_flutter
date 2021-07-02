import 'dart:convert';

class EstoqueModel {
  String? nome;
  String? quantidade;

  EstoqueModel({
    this.nome,
    this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'quantidade': quantidade,
    };
  }

  factory EstoqueModel.fromMap(Map<String, dynamic> map) {
    return EstoqueModel(
      nome: map['nome'],
      quantidade: map['quantidade'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstoqueModel.fromJson(String source) =>
      EstoqueModel.fromMap(json.decode(source));
}
