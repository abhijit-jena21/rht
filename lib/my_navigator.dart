import 'package:flutter/material.dart';
import './screens/subcategories.dart';
import './screens/otp/otp_screen.dart';

class MyNavigator {
  String number;
  String from;
  String id;
  Function func;
  MyNavigator(this.number, this.from);
  MyNavigator.category(this.id);
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

  static void goToLocation(BuildContext context) {
    // Navigator.pushNamed(context, "/location");
    Navigator.pushNamedAndRemoveUntil(context, "/location", (_) => false);
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }

  void goToCategory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubCategories(id)));
  }
}
