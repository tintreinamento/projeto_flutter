class EnderecoModel {
  String cep = "";
  String logradouro = "";
  String complemento = "";
  String numero = "";
  String bairro = "";
  String cidade = "";
  String estado = "";

  EnderecoModel(String cep, String logradouro, String complemento,
      String numero, String bairro, String cidade, String estado) {
    this.cep = cep;
    this.logradouro = logradouro;
    this.complemento = complemento;
    this.numero = numero;
    this.bairro = bairro;
    this.cidade = cidade;
    this.estado = estado;
  }
}
