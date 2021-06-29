import 'dart:convert';

import 'package:projeto_flutter/models/EnderecoModel.dart';

class FornecedorModel {
  String? nome;
  String? cpfCnpj;
  String? email;
  String? telefone;
  EnderecoModel? endereco;
  FornecedorModel({
    this.nome,
    this.cpfCnpj,
    this.email,
    this.telefone,
    this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpfCnpj': cpfCnpj,
      'email': email,
      'telefone': telefone,
      'endereco': endereco?.toMap(),
    };
  }

  factory FornecedorModel.fromMap(Map<String, dynamic> map) {
    return FornecedorModel(
      nome: map['nome'],
      cpfCnpj: map['cpfCnpj'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: EnderecoModel.fromMap(map['endereco']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FornecedorModel.fromJson(String source) =>
      FornecedorModel.fromMap(json.decode(source));
}
