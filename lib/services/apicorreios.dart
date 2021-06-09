Uri getUrl(String cep) {
  return Uri.parse('https://viacep.com.br/ws/' + cep + '/json/');
}
