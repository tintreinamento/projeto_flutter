import 'dart:convert';

import 'package:projeto_flutter/models/EnderecoModel.dart';

class ClienteModel {
  String? nome;
  String? cpfCnpj;
  String? dataNascimento;
  String? estadoCivil;
  String? email;
  String? sexo;
  String? telefone;
  EnderecoModel? endereco;

  ClienteModel({
    this.nome,
    this.cpfCnpj,
    this.dataNascimento,
    this.estadoCivil,
    this.email,
    this.sexo,
    this.telefone,
    this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpfCnpj': cpfCnpj,
      'dataNascimento': dataNascimento,
      'estadoCivil': estadoCivil,
      'email': email,
      'sexo': sexo,
      'telefone': telefone,
      'endereco': endereco?.toMap(),
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      nome: map['nome'],
      cpfCnpj: map['cpfCnpj'],
      dataNascimento: map['dataNascimento'],
      estadoCivil: map['estadoCivil'],
      email: map['email'],
      sexo: map['sexo'],
      telefone: map['telefone'],
      endereco: EnderecoModel.fromMap(map['endereco']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source));
}
