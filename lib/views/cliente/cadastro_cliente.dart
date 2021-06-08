import 'package:flutter/material.dart';

class ClienteCadastro extends StatefulWidget {
  @override
  _ClienteCadastroState createState() => _ClienteCadastroState();
}

class _ClienteCadastroState extends State<ClienteCadastro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: 73,
              decoration: BoxDecoration(color: Color.fromRGBO(0, 94, 181, 1)),
            ),
            Container(
              height: 27,
              margin: EdgeInsets.only(bottom: 109),
              decoration: BoxDecoration(color: Color.fromRGBO(206, 5, 5, 1)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('Cliente',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  )),
            ),
            Container(
              width: 330,
              height: 242,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xffbfbcbc),
                  width: 1,
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('Endereço',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  )),
            ),
            Container(
              width: 330,
              height: 242,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xffbfbcbc),
                  width: 1,
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 241,
              height: 31,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 241,
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff005db4),
                    ),
                    padding: const EdgeInsets.only(
                      left: 82,
                      right: 97,
                      top: 8,
                      bottom: 7,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Cadastrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
