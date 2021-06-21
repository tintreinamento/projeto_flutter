class EnderecoModel {
  var id;
  var idFornecedor;
  var idPais;
  var idCidade;
  var idEstado;
  var logradouro;
  var numero;
  var bairro;
  var cep;

  EnderecoModel(
      {this.id,
      this.idFornecedor,
      this.idPais,
      this.idCidade,
      this.idEstado,
      this.logradouro,
      this.numero,
      this.bairro,
      this.cep});

  factory EnderecoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnderecoModel(
        id: parsedJson['id'],
        idFornecedor: parsedJson['id_fornecedor'],
        idPais: parsedJson['id_pais'],
        idCidade: parsedJson['id_cidade'],
        idEstado: parsedJson['id_estado'],
        logradouro: parsedJson['logradouro'],
        numero: parsedJson['numero'],
        bairro: parsedJson['bairro'],
        cep: parsedJson['cep']);
  }

  Map<String, dynamic> toJson() => {
        'id_fornecedor': idFornecedor,
        'id_pais': idPais,
        'id_cidade': idCidade,
        'id_estado': idEstado,
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'cep': cep,
      };
}
