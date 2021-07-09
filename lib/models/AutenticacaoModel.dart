
import 'package:flutter/cupertino.dart';

class AutenticacaoModel extends ChangeNotifier {
  String? jwt;
  String usuario = "";

 setUsuario(String usuario){
   this.usuario = usuario;
   notifyListeners();
 }
}
