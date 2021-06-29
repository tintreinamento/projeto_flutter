import 'dart:convert';

class UsuarioModel {
  String? usuario;
  String? email;
  UsuarioModel({
    this.usuario,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'email': email,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      usuario: map['username'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source));
}
