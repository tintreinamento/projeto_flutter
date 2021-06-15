class EnderecoModel {
  var id;
  var logradouro;
  var numero;
  var bairro;
  var cep;

  EnderecoModel(
      {this.id,
      this.logradouro,
      this.numero,
      this.bairro,
      this.cep});

  factory EnderecoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnderecoModel(
        logradouro: parsedJson['logradouro'],
        numero: parsedJson['numero'],
        bairro: parsedJson['bairro'],
        cep: parsedJson['cep']);
  }

  Map<String, dynamic> toJson() => {
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'cep': cep,
      };
}
