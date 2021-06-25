class FuncionarioModel {
  var id;
  var usuario;
  var senha;
  var nome;
  var cargo;

  FuncionarioModel({this.id, this.usuario, this.senha, this.nome, this.cargo});

  factory FuncionarioModel.fromJson(Map<String, dynamic> parsedJson) {
    return FuncionarioModel(
        id: parsedJson['id'],
        usuario: parsedJson['usuario'],
        senha: parsedJson['senha'],
        nome: parsedJson['nome'],
        cargo: parsedJson['cargo']);
  }

  Map<String, dynamic> toJson() => {
        'usuario': usuario,
        'senha': senha,
        'nome': nome,
        'cargo': cargo,
      };
}
