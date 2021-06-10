import 'package:flutter/cupertino.dart';

class TextComponente extends StatelessWidget {
  String label;
  TextComponente({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
    );
  }
}
