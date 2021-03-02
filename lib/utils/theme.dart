import 'package:flutter/material.dart';
// import 'package:rht/utils/size_config.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    
    // double size = SizeConfig.defaultSize;
    // debugPrint(size.toString() + 'here');
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 30,
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
      
      headline4: base.headline4.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.black87,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 10.0,
        color: Colors.black87,
      ),
      bodyText2: base.bodyText2.copyWith(
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
