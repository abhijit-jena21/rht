import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rht/utils/size_config.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    // double size = SizeConfig.defaultSize;
    // debugPrint(size.toString() + 'here');
    return base.copyWith(
      headline1: GoogleFonts.montserrat(
    fontSize: 97,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    // color: Colors.black87.withOpacity(0.7)
  ),
  headline2: GoogleFonts.montserrat(
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    // color: Colors.black87.withOpacity(0.7)
  ),
  headline3: GoogleFonts.montserrat(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    // color: Colors.black87.withOpacity(0.7)
  ),
  headline4: GoogleFonts.montserrat(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    // color: Colors.black87.withOpacity(0.7)
  ),
  headline5: GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    // color: Colors.black87.withOpacity(0.7)
  ),
  headline6: GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    // color: Colors.black87.withOpacity(0.7)
  ),
  subtitle1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    // color: Colors.black87.withOpacity(0.7)
  ),
  subtitle2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    // color: Colors.black87.withOpacity(0.7)
  ),
  bodyText1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    // color: Colors.black87.withOpacity(0.7)
  ),
  bodyText2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    // color: Colors.black87.withOpacity(0.7)
  ),
  button: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    // color: Colors.black87.withOpacity(0.7)
  ),
  caption: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    // color: Colors.black87.withOpacity(0.7)
  ),
  overline: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    // color: Colors.black87.withOpacity(0.7)
  ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xff2885f7),
    accentColor: Color(0xff1a68c7),
    buttonColor: Color(0xff19a7e0)
  );
}
