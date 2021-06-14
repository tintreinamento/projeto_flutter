class EnderecoModel {
  var id;
  var cep;
  var logradouro;
  var numero;
  var bairro;
  var cidade;
  var uf;

  EnderecoModel(
      {this.id,
      this.logradouro,
      this.numero,
      this.bairro,
      this.cidade,
      this.cep,
      this.uf});

  factory EnderecoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnderecoModel(
        id: parsedJson['id'],
        logradouro: parsedJson['logradouro'],
        numero: parsedJson['numero'],
        bairro: parsedJson['bairro'],
        cidade: parsedJson['localidade'],
        cep: parsedJson['cep'],
        uf: parsedJson['uf']);
  }

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'cidade': cidade,
        'uf': uf,
      };
}
