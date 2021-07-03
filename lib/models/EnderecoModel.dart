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
        id: parsedJson['ID_ENDERECO'],
        idFornecedor: parsedJson['ID_FORNECEDOR'],
        idPais: parsedJson['ID_PAIS'],
        idCidade: parsedJson['ID_CIDADE'],
        idEstado: parsedJson['ID_ESTADO'],
        logradouro: parsedJson['LOGRADOURO'],
        numero: parsedJson['NUMERO'],
        bairro: parsedJson['BAIRRO'],
        cep: parsedJson['CEP']);
  }

  Map<String, dynamic> toJson() => {
        'ID_FORNECEDOR': idFornecedor,
        'ID_PAIS': idPais,
        'ID_CIDADE': idCidade,
        'ID_ESTADO': idEstado,
        'LOGRADOURO': logradouro,
        'NUMERO': numero,
        'BAIRRO': bairro,
        'CEP': cep,
      };
}
