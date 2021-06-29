import 'dart:convert';

import 'package:projeto_flutter/models/UsuarioModel.dart';

class AutenticacaoModel {
  String? jwt;
  String? identificador;
  String? senha;
  UsuarioModel? usuario;
  AutenticacaoModel({
    this.jwt,
    this.identificador,
    this.senha,
    this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
      'identifier': identificador,
      'password': senha,
      'user': usuario?.toMap(),
    };
  }

  factory AutenticacaoModel.fromMap(Map<String, dynamic> map) {
    return AutenticacaoModel(
      jwt: map['jwt'],
      identificador: map['identifier'],
      senha: map['password'],
      usuario: UsuarioModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutenticacaoModel.fromJson(String source) =>
      AutenticacaoModel.fromMap(json.decode(source));
}
