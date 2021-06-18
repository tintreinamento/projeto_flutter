class FornecedorModel {
  var id;
  var nome;
  var cpfCnpj;
  var email;
  var telefone;

  FornecedorModel(
      {this.id, this.nome, this.cpfCnpj, this.email, this.telefone});

  factory FornecedorModel.fromJson(Map<String, dynamic> parsedJson) {
    return FornecedorModel(
        nome: parsedJson['nome'],
        cpfCnpj: parsedJson['cpf_cnpj'],
        email: parsedJson['email'],
        telefone: parsedJson['telefone']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'cpf_cnpj': cpfCnpj,
        'email': email,
        'telefone': telefone
      };
}
