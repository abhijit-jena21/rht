import 'package:flutter/material.dart';

import './size_config.dart';

final kHintTextStyle = TextStyle(
  color: Colors.grey[400],
  fontFamily: 'Montserrat',
);
final kLabelStyle = TextStyle(
  fontSize: 15,
  color: Color(0xFFFFA751),
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

final kBoxDecorationStyle = BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: Color(0xFFFFA751), width: 2.0)
    // boxShadow: [
    //   BoxShadow(
    //     color: Colors.black12,
    //     blurRadius: 6.0,
    //     offset: Offset(0,2),
    //   ),
    // ]
    );

final kInputDecorationStyle = InputDecoration(
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
);

const defaultDuration = Duration(milliseconds: 250);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: Color(0xFF8B4513)),
  );
}
