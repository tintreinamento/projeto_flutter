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
        id: parsedJson['ID_CLIENTE'],
        nome: parsedJson['NOME'],
        cpf: parsedJson['CPF_CNPJ'],
        email: parsedJson['EMAIL'],
        dataNascimento: parsedJson['DATA_NASCIMENTO'],
        estadoCivil: parsedJson['ESTADO_CIVIL'],
        sexo: parsedJson['SEXO'],
        ddd: parsedJson['DDD'],
        numeroTelefone: parsedJson['NUMERO_TELEFONE'],
        logradouro: parsedJson['LOGRADOURO'],
        numero: parsedJson['NUMERO'],
        bairro: parsedJson['BAIRRO'],
        cidade: parsedJson['CIDADE'],
        cep: parsedJson['CEP'],
        uf: parsedJson['UF']);
  }

  Map<String, dynamic> toJson() => {
        'NOME': nome,
        'CPF_CNPJ': cpf,
        'DATA_NASCIMENTO': dataNascimento,
        'ESTADO_CIVIL': estadoCivil,
        'EMAIL': email,
        'SEXO': sexo,
        'DDD': ddd,
        'NUMERO_TELEFONE': numeroTelefone,
        'LOGRADOURO': logradouro,
        'NUMERO': numero,
        'BAIRRO': bairro,
        'CIDADE': cidade,
        'CEP': cep,
        'UF': uf,
      };
}
