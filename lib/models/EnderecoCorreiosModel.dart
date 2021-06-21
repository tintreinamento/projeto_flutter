class EnderecoCorreiosModel {
  var cep;
  var logradouro;
  var bairro;
  var localidade;
  var uf;

  EnderecoCorreiosModel(
      {this.cep, this.logradouro, this.bairro, this.localidade, this.uf});

  factory EnderecoCorreiosModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnderecoCorreiosModel(
        cep: parsedJson['cep'],
        logradouro: parsedJson['logradouro'],
        bairro: parsedJson['bairro'],
        localidade: parsedJson['localidade'],
        uf: parsedJson['uf']);
  }
}
