class FornecedorModel {
  var nome;
  var cpf_cnpj;
  var email;
  var telefone;
  var produto;
  var endereco;
  var pedido_fornecedors;

  FornecedorModel({
    this.nome,
    this.cpf_cnpj,
    this.email,
    this.telefone,
    this.produto,
    this.endereco,
    this.pedido_fornecedors
  });

  factory FornecedorModel.fromJson(Map<String, dynamic> parsedJson) {
    return FornecedorModel(
        nome: parsedJson['nome'],
        cpf_cnpj: parsedJson['cpf_cnpj'],
        email: parsedJson['email'],
        telefone: parsedJson['telefone'],
        produto: parsedJson['produto'],
        endereco: parsedJson['endereco'],
        pedido_fornecedors: parsedJson['pedido_fornecedors']);

  }


  Map<String, dynamic> toJson() => {'nome': nome, 'cpf_cnpj': cpf_cnpj, 'email': email,'telefone': telefone,'produto': produto,'endereco': endereco, 'pedido_fornecedors': pedido_fornecedors};
}
