import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: Color(0xffFFAA57),
      ),
      headline2: base.headline2.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.black87,
      ),
      headline3: base.headline3.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        color: Colors.black54,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 10.0,
        color: Colors.black87,
      ),
      bodyText2: base.bodyText1.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 10.0,
        color: Colors.white,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xffFFAA57),
    accentColor: Color(0xffFF4E00),
  );
}
