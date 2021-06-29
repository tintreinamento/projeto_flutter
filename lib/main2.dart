import 'package:projeto_flutter/controllers/AutenticacaoController.dart';
import 'package:projeto_flutter/models/AutenticacaoModel.dart';
import 'package:projeto_flutter/models/UsuarioModel.dart';
import 'package:projeto_flutter/services/Auth.dart';

void main() async {
  AutenticacaoModel autenticacaoModel = new AutenticacaoModel(
      jwt: 'teste', identificador: 'academiati', senha: 'academiati');

  print(autenticacaoModel.toJson());

  AutenticacaoController autenticacaoController = new AutenticacaoController();
  AutenticacaoModel resposta =
      await autenticacaoController.crie(autenticacaoModel);

  login(resposta.jwt.toString());

  print('teste: ' + getToken());

  logout();
  print('teste: ' + getToken());
}
