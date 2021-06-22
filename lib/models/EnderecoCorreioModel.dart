class EnderecoCorreioModel {
  var cep;
  var logradouro;
  var complemento;
  var bairro;
  var localidade;
  var uf;
  var ibge;
  var gia;
  var ddd;
  var siafi;

  EnderecoCorreioModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi});

  factory EnderecoCorreioModel.fromJson(Map<String, dynamic> parsedJson) {
    return EnderecoCorreioModel(
      cep: parsedJson['cep'],
      logradouro: parsedJson['logradouro'],
      complemento: parsedJson['complemento'],
      bairro: parsedJson['bairro'],
      localidade: parsedJson['localidade'],
      uf: parsedJson['uf'],
      ibge: parsedJson['ibge'],
      gia: parsedJson['gia'],
      ddd: parsedJson['ddd'],
      siafi: parsedJson['siafi'],
    );
  }

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'localidade': localidade,
        'uf': uf,
        'ibge': ibge,
        'gia': gia,
        'ddd': ddd,
        'siafi': siafi,
      };
}
