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
        id: parsedJson['ID_FORNECEDOR'],
        nome: parsedJson['NOME'],
        cpfCnpj: parsedJson['CPF_CNPJ'],
        email: parsedJson['EMAIL'],
        telefone: parsedJson['TELEFONE']);
  }

  Map<String, dynamic> toJson() =>
      {'NOME': nome, 'CPF_CNPJ': cpfCnpj, 'EMAIL': email, 'TELEFONE': telefone};
}
