import 'package:flutter/material.dart';

//Padding and margin

final paddingPadrao = EdgeInsets.all(10);

//Colors
final colorAzul = Color.fromRGBO(0, 94, 181, 1);
final colorVermelho = Color.fromRGBO(206, 5, 5, 1);
final colorVerde = Color.fromRGBO(0, 184, 0, 1);
final colorBranco = Color.fromRGBO(255, 255, 255, 1);
final colorPreto = Color.fromRGBO(0, 0, 0, 1);
final colorCinza = Color.fromRGBO(235, 231, 231, 1);

//Font

final fontFamilia = 'Roboto';
final fontEstilo = FontStyle.normal;
final fontTamanho = 72.0;
final fontLargura = FontWeight.w700;

//Input Decoration

final inputDecorationComponent = InputDecoration(
    contentPadding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(191, 188, 188, 1))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(191, 188, 188, 1))),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ));

final boxDecorationComponent = BoxDecoration(
    border: Border.all(color: colorCinza, width: 1),
    borderRadius: BorderRadius.circular(25));
