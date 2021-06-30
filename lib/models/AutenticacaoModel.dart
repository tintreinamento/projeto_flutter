import 'dart:convert';

import 'package:projeto_flutter/models/UsuarioModel.dart';

class AutenticacaoModel {
  String? jwt;
  UsuarioModel? user;

  AutenticacaoModel({
    this.jwt,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
      'user': user?.toMap(),
    };
  }

  factory AutenticacaoModel.fromMap(Map<String, dynamic> map) {
    return AutenticacaoModel(
      jwt: map['jwt'],
      user: UsuarioModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutenticacaoModel.fromJson(String source) =>
      AutenticacaoModel.fromMap(json.decode(source));
}
