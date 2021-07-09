import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 109),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffc4c4c4),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 1181,
                  height: 1485,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        top: 300,
                        child: Transform.scale(
                          scale: 1.8,
                          child: Transform.rotate(
                            angle: -0.86,
                            child: Container(
                              width: 489.97,
                              height: 958.37,
                              color: Color(0xffce0505),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 355.84,
                        top: 0,
                        child: Transform.scale(
                          scale: 1.85,
                          child: Transform.rotate(
                            angle: -0.66,
                            child: Container(
                              width: 369.97,
                              height: 650,
                              color: Color(0xff005db4),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 360,
                          height: 220,
                          child: Text(
                            "Sistema Gestão\nde Vendas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
