import 'package:flutter/material.dart';

class ClienteCadastro extends StatefulWidget {
  @override
  _ClienteCadastroState createState() => _ClienteCadastroState();
}

class _ClienteCadastroState extends State<ClienteCadastro> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome Cliente',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'CPF/CNPJ',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
