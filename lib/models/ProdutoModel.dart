import 'dart:convert';

class ProdutoModel {
  String? nome;
  String? descricao;
  String? preco;

  ProdutoModel({
    this.nome,
    this.descricao,
    this.preco,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source));
}
