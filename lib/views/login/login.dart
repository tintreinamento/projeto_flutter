import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Text('LOGIN',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )),
          ),
          Container(
            width: 316,
            margin: EdgeInsets.only(left: 26, right: 26),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(116, 181, 241, 1), width: 1),
                borderRadius: BorderRadius.circular(25)),
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.fromLTRB(26, 31, 26, 13),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Usuário:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(186, 171, 171, 1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(186, 171, 171, 1))),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu usuário';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 23),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Senha:',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )),
                    ),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(186, 171, 171, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(186, 171, 171, 1))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite sua senha';
                          }
                          return null;
                        }),
                    Container(
                      width: 199,
                      height: 40,
                      margin: EdgeInsets.only(top: 18, bottom: 13),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ))),
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Processando dados...')))
                                  }
                              },
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
