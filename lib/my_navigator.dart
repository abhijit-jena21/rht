import 'package:flutter/material.dart';
import './screens/otp/otp_screen.dart';

class MyNavigator {
  String number;
  String from;
  Function func;
  MyNavigator(this.number, this.from);
  static void goToSignup(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }

  void goToOtp(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OtpScreen(number, from)));
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }
}
