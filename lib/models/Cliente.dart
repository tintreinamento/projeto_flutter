class Cliente {
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
  var pedidos;

  Cliente(
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
      this.uf,
      this.pedidos});

  factory Cliente.fromJson(Map<String, dynamic> parsedJson) {
    return Cliente(
        id: parsedJson['id'],
        nome: parsedJson['nome'],
        cpf: parsedJson['cpf'],
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
        uf: parsedJson['uf'],
        pedidos: parsedJson['pedidos']);
  }
}
