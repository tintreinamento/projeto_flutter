class FuncionarioModel {
  var id;
  var usuario;
  var senha;
  var nome;
  var cargo;

  FuncionarioModel({this.id, this.usuario, this.senha, this.nome, this.cargo});

  factory FuncionarioModel.fromJson(Map<String, dynamic> parsedJson) {
    return FuncionarioModel(
        id: parsedJson['ID_FUNCIONARIO'],
        usuario: parsedJson['USUARIO'],
        senha: parsedJson['SENHA'],
        nome: parsedJson['NOME'],
        cargo: parsedJson['CARGO']);
  }

  Map<String, dynamic> toJson() => {
        'USUARIO': usuario,
        'SENHA': senha,
        'NOME': nome,
        'CARGO': cargo,
      };
}
