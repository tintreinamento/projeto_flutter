import 'dart:convert';

class FuncionarioModel {
  String? nome;
  String? cpfCnpj;

  FuncionarioModel({
    this.nome,
    this.cpfCnpj,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpfCnpj': cpfCnpj,
    };
  }

  factory FuncionarioModel.fromMap(Map<String, dynamic> map) {
    return FuncionarioModel(
      nome: map['nome'],
      cpfCnpj: map['cpfCnpj'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FuncionarioModel.fromJson(String source) =>
      FuncionarioModel.fromMap(json.decode(source));
}
