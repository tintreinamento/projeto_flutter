class ClienteModel {
  var id;
  var nome;
  var cpf;
  var email;
  var estadoCivil;
  var dataNascimento;
  var sexo;
  var ddd;
  var numeroTelefone;
  var logradouro;
  var numero;
  var bairro;
  var cidade;
  var cep;
  var uf;

  ClienteModel(
      {this.id,
      this.nome,
      this.cpf,
      this.email,
      this.dataNascimento,
      this.estadoCivil,
      this.sexo,
      this.ddd,
      this.numeroTelefone,
      this.logradouro,
      this.numero,
      this.bairro,
      this.cidade,
      this.cep,
      this.uf});

  factory ClienteModel.fromJson(Map<String, dynamic> parsedJson) {
    return ClienteModel(
        id: parsedJson['id'],
        nome: parsedJson['nome'],
        cpf: parsedJson['cpf'].toString(),
        email: parsedJson['email'],
        dataNascimento: parsedJson['data_de_nascimento'],
        estadoCivil: parsedJson['estado_civil'],
        sexo: parsedJson['sexo'],
        ddd: parsedJson['ddd'],
        numeroTelefone: parsedJson['numero_telefone'],
        logradouro: parsedJson['logradouro'],
        numero: parsedJson['numero'],
        bairro: parsedJson['bairro'],
        cidade: parsedJson['cidade'],
        cep: parsedJson['cep'],
        uf: parsedJson['uf']);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'cpf': cpf.toString(),
        'email': email,
        'data_de_nascimento': dataNascimento,
        'estado_civil': estadoCivil,
        'sexo': sexo,
        'ddd': ddd,
        'numero_telefone': numeroTelefone,
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'cidade': cidade,
        'cep': cep,
        'uf': uf,
      };
}
