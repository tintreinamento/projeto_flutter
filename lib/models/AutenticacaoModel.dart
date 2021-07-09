
import 'package:flutter/cupertino.dart';
import 'package:projeto_flutter/models/FuncionarioModel.dart';

class AutenticacaoModel extends ChangeNotifier {
  String? jwt;
  FuncionarioModel? funcionarioModel;

 setFuncionario(FuncionarioModel funcionarioModel){
   this.funcionarioModel = funcionarioModel;
   notifyListeners();
 }
}
